import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/bill_record.dart';
import '../../data/models/ad_record.dart';
import '../../data/models/recurring_rule.dart';
import '../../data/models/health_score_history.dart';
import '../../data/models/account_record.dart';

class StorageService {
  static late Box<BillRecord> _billBox;
  static late Box<AdRecord>   _adBox;
  static late Box<RecurringRule> _recurringBox;
  static late Box<AccountRecord> _accountBox;
  static late SharedPreferences _prefs;

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(BillRecordAdapter());
    Hive.registerAdapter(AdRecordAdapter());
    Hive.registerAdapter(RecurringRuleAdapter());
    Hive.registerAdapter(AccountRecordAdapter());
    _billBox       = await Hive.openBox<BillRecord>('bill_records');
    _adBox         = await Hive.openBox<AdRecord>('ad_records');
    _recurringBox  = await Hive.openBox<RecurringRule>('recurring_rules');
    _accountBox    = await Hive.openBox<AccountRecord>('accounts');
    _prefs   = await SharedPreferences.getInstance();
  }

  static Future<void> initForTest() async {
    _prefs = await SharedPreferences.getInstance();
    // 单元测试环境没有 path_provider 插件实现，Hive.initFlutter() 会抛
    // MissingPluginException；改用 Hive.init(tempDir) 绕开插件依赖，
    // 让依赖 _adBox 的代码（如 AdService.onInit）在测试里也能正常跑。
    final dir = Directory.systemTemp.createTempSync('ads_billtrack_test_hive_');
    Hive.init(dir.path);
    if (!Hive.isAdapterRegistered(AdRecordAdapter().typeId)) {
      Hive.registerAdapter(AdRecordAdapter());
    }
    _adBox = await Hive.openBox<AdRecord>('ad_records_test');
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

  static String get joinDate => _prefs.getString('join_date') ?? DateTime.now().toIso8601String();
  static Future<void> setJoinDate() async {
    if (!_prefs.containsKey('join_date')) {
      await _prefs.setString('join_date', DateTime.now().toIso8601String());
    }
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

  static List<BillRecord> billsForYear(int year) =>
      _billBox.values
          .where((b) => b.date.year == year)
          .toList()
        ..sort((a, b) => b.date.compareTo(a.date));

  // ── 资产账户 ──────────────────────────────────────────────────────
  static List<AccountRecord> get allAccounts =>
      _accountBox.values.toList()
        ..sort((a, b) => a.sortOrder != b.sortOrder
            ? a.sortOrder.compareTo(b.sortOrder)
            : a.createdAt.compareTo(b.createdAt));

  static AccountRecord? accountById(String id) {
    try { return _accountBox.values.firstWhere((a) => a.id == id); }
    catch (_) { return null; }
  }

  static Future<void> saveAccount(AccountRecord a) => _accountBox.put(a.id, a);

  static Future<void> deleteAccount(String id) => _accountBox.delete(id);

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

  static Future<void> saveAdRecord(String adType) async {
    final record = AdRecord()
      ..id          = const Uuid().v4()
      ..adType      = adType
      ..coinsEarned = 0
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

  // ── 定期账单规则 ──────────────────────────────────────────────────
  static List<RecurringRule> get allRecurringRules =>
      _recurringBox.values.where((r) => r.isActive).toList()
        ..sort((a, b) => a.nextDueDate.compareTo(b.nextDueDate));

  static Future<void> saveRecurringRule(RecurringRule rule) =>
      _recurringBox.put(rule.id, rule);

  static Future<void> deleteRecurringRule(String id) =>
      _recurringBox.delete(id);

  // ── 健康评分历史 ──────────────────────────────────────────────────
  static List<HealthScoreHistory> get scoreHistory {
    final raw = _prefs.getString('health_score_history');
    if (raw == null) return [];
    final list = jsonDecode(raw) as List;
    return list.map((e) => HealthScoreHistory.fromJson(e as Map<String, dynamic>)).toList();
  }

  static Future<void> saveScoreHistory(HealthScoreHistory h) async {
    final list = scoreHistory.where(
      (e) => !(e.year == h.year && e.month == h.month),
    ).toList()..add(h);
    // 只保留最近 12 个月
    list.sort((a, b) => DateTime(a.year, a.month).compareTo(DateTime(b.year, b.month)));
    final kept = list.length > 12 ? list.sublist(list.length - 12) : list;
    await _prefs.setString('health_score_history', jsonEncode(kept.map((e) => e.toJson()).toList()));
  }

  // ── 月度总结 flag ─────────────────────────────────────────────────
  static String get _summaryFlagKey {
    final now = DateTime.now();
    return 'monthly_summary_shown_${now.year}_${now.month}';
  }
  static bool get monthlySummaryShown => _prefs.getBool(_summaryFlagKey) ?? false;
  static Future<void> setMonthlySummaryShown() => _prefs.setBool(_summaryFlagKey, true);

  // ── 认证（登录 Token 与用户信息）─────────────────────────────────
  static String? get authToken => _prefs.getString('auth_token');
  static Future<void> setAuthToken(String v) => _prefs.setString('auth_token', v);

  static Map<String, dynamic>? get authUserInfo {
    final raw = _prefs.getString('auth_user_info');
    if (raw == null) return null;
    // 防御:本地数据损坏时按未登录处理,避免启动崩溃
    try {
      return jsonDecode(raw) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }

  static Future<void> setAuthUserInfo(Map<String, dynamic> json) =>
      _prefs.setString('auth_user_info', jsonEncode(json));

  static Future<void> clearAuth() async {
    await _prefs.remove('auth_token');
    await _prefs.remove('auth_user_info');
  }

  // ── 注销：清空全部本地数据 ─────────────────────────────────────────
  static Future<void> wipeAllData() async {
    await _billBox.clear();
    await _adBox.clear();
    await _recurringBox.clear();
    await _accountBox.clear();
    await _prefs.clear();
  }
}
