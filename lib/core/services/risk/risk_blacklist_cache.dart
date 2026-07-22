import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/risk_config.dart';
import 'risk_models.dart';

/// 黑名单本地缓存:仅做快速过滤优化,最终拦截以服务端 /risk/decide 为准。
///
/// 注意:当前后端同步协议只支持增量新增,没有删除语义(见设计文档 §6),
/// 本地集合只增不减。如果黑名单规模长期增长导致 SharedPreferences 存储/
/// 序列化开销变得不可接受,需要评估换成更适合大数据量的本地存储(如 sqlite)。
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
    final now = DateTime.now();
    await _prefs.setString(
      _kItems,
      jsonEncode(_keys.map((k) {
        final parts = k.split(':');
        return {'type': parts.first, 'value': parts.sublist(1).join(':')};
      }).toList()),
    );
    await _prefs.setInt(_kLastSyncedAt, now.millisecondsSinceEpoch);
    await _prefs.setInt(_kVersion, newVersion);
    _lastSyncedAt = now;
    _version = newVersion;
  }

  /// 仅供测试:直接设置 lastSyncedAt 以模拟缓存过期，不落盘。
  @visibleForTesting
  Future<void> debugSetLastSyncedAt(DateTime time) async {
    _lastSyncedAt = time;
  }
}
