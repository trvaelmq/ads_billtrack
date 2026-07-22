import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/risk_config.dart';
import 'risk_models.dart';

/// 黑名单本地缓存:仅做快速过滤优化,最终拦截以服务端 /risk/decide 为准。
class RiskBlacklistCache {
  static const _kVersion = 'risk_blacklist_version';
  static const _kItems = 'risk_blacklist_items';
  static const _kLastSyncedAt = 'risk_blacklist_last_synced_at';

  late SharedPreferences _prefs;
  int _version = 0;
  final Set<String> _keys = {};
  DateTime? _lastSyncedAt;

  int get currentVersion => _version;

  Future<void> load() async {
    _prefs = await SharedPreferences.getInstance();
    _version = _prefs.getInt(_kVersion) ?? 0;
    final raw = _prefs.getString(_kItems);
    _keys.clear();
    if (raw != null) {
      final list = (jsonDecode(raw) as List).cast<Map<String, dynamic>>();
      _keys.addAll(list.map((e) => BlacklistItem.fromJson(e).key));
    }
    final syncedRaw = _prefs.getInt(_kLastSyncedAt);
    _lastSyncedAt =
        syncedRaw == null ? null : DateTime.fromMillisecondsSinceEpoch(syncedRaw);
  }

  bool contains({required String type, required String value}) =>
      _keys.contains('$type:$value');

  /// 是否需要全量刷新(缓存过期或从未同步过)。
  bool get shouldFullRefresh {
    final last = _lastSyncedAt;
    if (last == null) return true;
    return DateTime.now().difference(last) > RiskConfig.blacklistCacheTtl;
  }

  /// 本次同步时应携带的 version 参数:过期则传 0 做全量刷新,否则传当前 version 做增量。
  int get syncVersion => shouldFullRefresh ? 0 : _version;

  /// 合并服务端返回的新增项并持久化;newVersion 为响应里的 currentVersion。
  Future<void> merge({
    required int newVersion,
    required List<BlacklistItem> items,
  }) async {
    _keys.addAll(items.map((e) => e.key));
    _version = newVersion;
    _lastSyncedAt = DateTime.now();
    await _prefs.setInt(_kVersion, _version);
    await _prefs.setInt(_kLastSyncedAt, _lastSyncedAt!.millisecondsSinceEpoch);
    await _prefs.setString(
      _kItems,
      jsonEncode(_keys.map((k) {
        final parts = k.split(':');
        return {'type': parts.first, 'value': parts.sublist(1).join(':')};
      }).toList()),
    );
  }

  /// 仅供测试:直接设置 lastSyncedAt 以模拟缓存过期，不落盘。
  Future<void> debugSetLastSyncedAt(DateTime time) async {
    _lastSyncedAt = time;
  }
}
