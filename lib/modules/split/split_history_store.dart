// lib/modules/split/split_history_store.dart
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'split_controller.dart';

class SplitHistoryEntry {
  final String desc;
  final double total;
  final List<SplitMember> members;
  final DateTime time;

  SplitHistoryEntry({
    required this.desc,
    required this.total,
    required this.members,
    required this.time,
  });

  int get paidCount => members.where((m) => m.paid).length;

  Map<String, dynamic> toJson() => {
        'desc': desc,
        'total': total,
        'members': members
            .map((m) => {'name': m.name, 'amount': m.amount, 'paid': m.paid})
            .toList(),
        'time': time.toIso8601String(),
      };

  static SplitHistoryEntry fromJson(Map<String, dynamic> j) => SplitHistoryEntry(
        desc: (j['desc'] ?? '') as String,
        total: (j['total'] as num?)?.toDouble() ?? 0,
        members: (((j['members'] as List?) ?? []))
            .map((e) => SplitMember(
                  name: (e['name'] ?? '') as String,
                  amount: (e['amount'] as num?)?.toDouble() ?? 0,
                  paid: (e['paid'] ?? false) as bool,
                ))
            .toList(),
        time: DateTime.tryParse((j['time'] ?? '') as String) ??
            DateTime.fromMillisecondsSinceEpoch(0),
      );
}

/// 分摊单分享文本：controller 与历史页共用，避免重复。
String buildSplitShareText(String desc, double total, List<SplitMember> members) {
  final buf = StringBuffer();
  buf.writeln('📋 账单分摊：$desc');
  buf.writeln('💰 总金额：¥${total.toStringAsFixed(2)}');
  buf.writeln('👥 共 ${members.length} 人');
  buf.writeln('---');
  for (final m in members) {
    buf.writeln('${m.name}：¥${m.amount.toStringAsFixed(2)}');
  }
  return buf.toString();
}

class SplitHistoryStore {
  static const _key = 'split_history';

  static Future<List> _loadRawList(SharedPreferences prefs) async {
    final raw = prefs.getString(_key);
    if (raw == null) return [];
    try {
      return jsonDecode(raw) as List;
    } catch (_) {
      return [];
    }
  }

  static Future<List<SplitHistoryEntry>> list() async {
    final prefs = await SharedPreferences.getInstance();
    try {
      final decoded = await _loadRawList(prefs);
      return decoded
          .whereType<Map<String, dynamic>>()
          .map((e) => SplitHistoryEntry.fromJson(e))
          .toList();
    } catch (_) {
      return [];
    }
  }

  static Future<void> add(SplitHistoryEntry entry) async {
    final prefs = await SharedPreferences.getInstance();
    final list = await _loadRawList(prefs);
    list.insert(0, entry.toJson());
    if (list.length > 20) list.removeRange(20, list.length);
    await prefs.setString(_key, jsonEncode(list));
  }

  static Future<void> removeByTime(DateTime time) async {
    final prefs = await SharedPreferences.getInstance();
    final iso = time.toIso8601String();
    final list = (await _loadRawList(prefs))
        .where((e) => e is! Map || e['time'] != iso)
        .toList();
    await prefs.setString(_key, jsonEncode(list));
  }

  static Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_key);
  }
}
