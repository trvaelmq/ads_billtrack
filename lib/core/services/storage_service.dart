import 'dart:convert';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/bill_record.dart';
import '../../data/models/ad_record.dart';

class StorageService {
  static late Box<BillRecord> _billBox;
  static late Box<AdRecord>   _adBox;
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BillRecordAdapter());
    Hive.registerAdapter(AdRecordAdapter());
    _billBox = await Hive.openBox<BillRecord>('bill_records');
    _adBox   = await Hive.openBox<AdRecord>('ad_records');
    _prefs   = await SharedPreferences.getInstance();
  }

  static Future<void> initForTest() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ── 用户信息 ──────────────────────────────────────────────────────
  static bool   get isFirstLaunch  => _prefs.getBool('first_launch') ?? true;
  static Future<void> setFirstLaunchDone() => _prefs.setBool('first_launch', false);

  static bool   get privacyAccepted => _prefs.getBool('privacy_accepted') ?? false;
  static Future<void> setPrivacyAccepted() => _prefs.setBool('privacy_accepted', true);

  static bool   get isProfileSet   => nickname != '用户';

  /// 设备唯一 ID：首次生成后永久存储，格式 前2位字母 + 后6位数字，如 AB123456
  /// 用 UUID v4 的哈希值做种子，碰撞概率极低
  static String get userId {
    final existing = _prefs.getString('user_id');
    if (existing != null) return existing;
    // 用 UUID 哈希值做随机种子，保证唯一性
    final uuid = const Uuid().v4().replaceAll('-', '');
    final seed = uuid.codeUnits.fold(0, (a, b) => a ^ b ^ (a << 5));
    final rng  = Random(seed ^ DateTime.now().microsecondsSinceEpoch);
    const letters  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    final letters2 = List.generate(2, (_) => letters[rng.nextInt(26)]).join();
    final digits8  = List.generate(8, (_) => rng.nextInt(10)).join();
    final id = '$letters2$digits8';
    _prefs.setString('user_id', id);
    return id;
  }

  static String get nickname => _prefs.getString('nickname') ?? '用户';
  static Future<void> setNickname(String v) => _prefs.setString('nickname', v);

  static int    get totalCoins => _prefs.getInt('total_coins') ?? 0;
  static Future<void> addCoins(int v) => _prefs.setInt('total_coins', totalCoins + v);

  static String get joinDate => _prefs.getString('join_date') ?? DateTime.now().toIso8601String();
  static Future<void> setJoinDate() async {
    if (!_prefs.containsKey('join_date')) {
      await _prefs.setString('join_date', DateTime.now().toIso8601String());
    }
  }

  // ── 签到 ──────────────────────────────────────────────────────────
  static bool get hasCheckedInToday {
    final last = _prefs.getString('last_checkin_date');
    if (last == null) return false;
    final d = DateTime.parse(last);
    final now = DateTime.now();
    return d.year == now.year && d.month == now.month && d.day == now.day;
  }

  static int get checkinStreak => _prefs.getInt('checkin_streak') ?? 0;

  static Future<int> doCheckin() async {
    if (hasCheckedInToday) return 0;
    final now = DateTime.now();
    final last = _prefs.getString('last_checkin_date');
    int streak = checkinStreak;
    if (last != null) {
      final d = DateTime.parse(last);
      final diff = now.difference(DateTime(d.year, d.month, d.day)).inDays;
      streak = diff == 1 ? streak + 1 : 1;
    } else {
      streak = 1;
    }
    await _prefs.setString('last_checkin_date', now.toIso8601String());
    await _prefs.setInt('checkin_streak', streak);
    final coins = (streak % 7 == 0) ? 20 : 5;
    await addCoins(coins);
    return coins;
  }

  // ── 预算 ──────────────────────────────────────────────────────────
  static Map<String, double> get budgets {
    final raw = _prefs.getString('budgets_json');
    if (raw == null) return {};
    final map = jsonDecode(raw) as Map<String, dynamic>;
    return map.map((k, v) => MapEntry(k, (v as num).toDouble()));
  }

  static Future<void> setBudget(String categoryId, double amount) async {
    final b = Map<String, double>.from(budgets);
    b[categoryId] = amount;
    await _prefs.setString('budgets_json', jsonEncode(b));
  }

  // ── 账单记录 ──────────────────────────────────────────────────────
  static List<BillRecord> get allBills =>
      _billBox.values.toList()..sort((a, b) => b.date.compareTo(a.date));

  static Future<void> saveBill(BillRecord bill) => _billBox.put(bill.id, bill);

  static Future<void> deleteBill(String id) => _billBox.delete(id);

  static List<BillRecord> billsForMonth(int year, int month) =>
      _billBox.values
          .where((b) => b.date.year == year && b.date.month == month)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  // ── 通知去重 flag ─────────────────────────────────────────────────
  static bool hasFlag(String key) => _prefs.getBool(key) ?? false;
  static Future<void> setFlag(String key) => _prefs.setBool(key, true);

  // ── 广告记录 ──────────────────────────────────────────────────────
  static List<AdRecord> get adRecords =>
      _adBox.values.toList()..sort((a, b) => b.watchedAt.compareTo(a.watchedAt));

  static List<AdRecord> get todayAdRecords {
    final now = DateTime.now();
    return adRecords.where((r) {
      return r.watchedAt.year == now.year &&
             r.watchedAt.month == now.month &&
             r.watchedAt.day == now.day;
    }).toList();
  }

  static Future<void> saveAdRecord(String adType, int coins) async {
    final record = AdRecord()
      ..id          = const Uuid().v4()
      ..adType      = adType
      ..coinsEarned = coins
      ..watchedAt   = DateTime.now();
    await _adBox.put(record.id, record);
  }

  // ── 自定义分类 ────────────────────────────────────────────────────
  static List<Map<String, dynamic>> get customCategories {
    final raw = _prefs.getString('custom_categories');
    if (raw == null) return [];
    return List<Map<String, dynamic>>.from(
      (jsonDecode(raw) as List).cast<Map<String, dynamic>>(),
    );
  }

  static Future<void> saveCustomCategories(
      List<Map<String, dynamic>> cats) async {
    await _prefs.setString('custom_categories', jsonEncode(cats));
  }
}
