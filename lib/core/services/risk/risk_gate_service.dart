import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../constants/ad_config.dart';
import '../../constants/risk_config.dart';
import '../../network/api_client.dart';
import '../../../data/models/risk_event_record.dart';
import 'risk_blacklist_cache.dart';
import 'risk_event_queue.dart';
import 'risk_models.dart';
import 'risk_signer.dart';

typedef DeviceIdProvider = Future<String?> Function();

/// 风控 SDK 唯一对外入口:决策拦截 + 事件上报 + 黑名单预拉取。
class RiskGateService extends GetxService {
  static RiskGateService get to => Get.find();

  static const _method = MethodChannel(AdConfig.methodChannel);

  final ApiClient _api;
  final RiskBlacklistCache _blacklist = RiskBlacklistCache();
  late final RiskEventQueue _queue;
  final DeviceIdProvider _deviceIdProvider;

  String? _deviceId;
  Timer? _flushTimer;

  RiskGateService({
    required ApiClient api,
    required Box<RiskEventRecord> eventBox,
    DeviceIdProvider? deviceIdProvider,
  })  : _api = api,
        _deviceIdProvider = deviceIdProvider ??
            (() => _method.invokeMethod<String>('getDeviceId')) {
    _queue = RiskEventQueue(eventBox);
  }

  Future<RiskGateService> init() async {
    if (_deviceId == null) {
      try {
        _deviceId = await _deviceIdProvider();
        if (_deviceId == null) {
          debugPrint(
              '[RiskGate] deviceId is null, risk gate will fail-open until next init()');
        } else {
          debugPrint('[RiskGate] init: deviceId=$_deviceId');
        }
      } catch (e) {
        debugPrint(
            '[RiskGate] deviceId fetch failed, risk gate will fail-open until next init(): $e');
      }
    }
    await _blacklist.load();
    debugPrint(
        '[RiskGate] init: local blacklist loaded, version=${_blacklist.currentVersion}, syncVersion=${_blacklist.syncVersion}');
    await _syncBlacklist();
    _flushTimer?.cancel();
    _flushTimer = Timer.periodic(
        RiskConfig.eventQueueFlushInterval, (_) => _flushQueue());
    return this;
  }

  Future<void> _syncBlacklist() async {
    try {
      final path = '${RiskConfig.blacklistSyncPath}?version=${_blacklist.syncVersion}';
      debugPrint('[RiskGate] blacklist sync: GET $path');
      final res = await _api.getJson<Map<String, dynamic>>(
        path,
        parser: (d) => d as Map<String, dynamic>,
      );
      final data = res.data;
      if (data == null) {
        debugPrint(
            '[RiskGate] blacklist sync: empty response data (code=${res.code}, message=${res.message}), keep old cache');
        return;
      }
      final items = (data['items'] as List? ?? [])
          .cast<Map<String, dynamic>>()
          .map(BlacklistItem.fromJson)
          .toList();
      final version = data['currentVersion'] as int? ?? _blacklist.currentVersion;
      await _blacklist.merge(newVersion: version, items: items);
      debugPrint(
          '[RiskGate] blacklist sync: ok, newVersion=$version, newItemsCount=${items.length}, totalKnownVersion=${_blacklist.currentVersion}');
    } catch (e) {
      debugPrint('[RiskGate] blacklist sync failed: $e');
    }
  }

  /// 调联盟广告 SDK 前调用。本地黑名单命中直接 block；否则调 /risk/decide，
  /// 超时/异常/解析失败一律本地降级为 pass。
  Future<RiskAction> decide({
    required String adSlotId,
    required String adFormat,
  }) async {
    final deviceId = _deviceId;
    debugPrint('[RiskGate] decide: adSlotId=$adSlotId adFormat=$adFormat deviceId=$deviceId');
    if (deviceId != null && _blacklist.contains(type: 'DEVICE', value: deviceId)) {
      debugPrint('[RiskGate] decide: local blacklist hit -> block, skip /risk/decide');
      return RiskAction.block;
    }
    if (deviceId == null) {
      debugPrint('[RiskGate] decide: deviceId unavailable -> fail-open pass');
      return RiskAction.pass;
    }

    final body = _buildSignedBody(
      deviceId: deviceId,
      adSlotId: adSlotId,
      eventType: RiskEventType.request,
      adFormat: adFormat,
    );
    try {
      final res = await _api.postJson<Map<String, dynamic>>(
        RiskConfig.decidePath,
        body,
        parser: (d) => d as Map<String, dynamic>,
      );
      final data = res.data;
      if (data == null) {
        debugPrint(
            '[RiskGate] decide: empty response data (code=${res.code}, message=${res.message}) -> fail-open pass');
        return RiskAction.pass;
      }
      final result = DecisionResult.fromJson(data);
      debugPrint(
          '[RiskGate] decide: result action=${result.action} reason=${result.reason} '
          'confidence=${result.confidence}/${result.confidenceLevel} requestId=${result.requestId}');
      return result.action;
    } catch (e) {
      debugPrint('[RiskGate] decide failed, fallback pass: $e');
      return RiskAction.pass;
    }
  }

  /// 曝光/点击/转化发生后调用,异步入队上报,不阻塞调用方。
  void reportEvent({
    required String adFormat,
    required String eventType,
    Map<String, dynamic>? signals,
  }) {
    final deviceId = _deviceId;
    debugPrint(
        '[RiskGate] reportEvent: adFormat=$adFormat eventType=$eventType signals=$signals deviceId=$deviceId');
    if (deviceId == null) {
      debugPrint('[RiskGate] reportEvent: deviceId unavailable, event dropped (not queued)');
      return;
    }
    final body = _buildSignedBody(
      deviceId: deviceId,
      adSlotId: null,
      eventType: eventType,
      adFormat: adFormat,
      signals: signals,
    );
    unawaited(_queue.enqueue(body).then((_) {
      debugPrint(
          '[RiskGate] reportEvent: enqueued, pendingCount=${_queue.pendingCount}, triggering flush');
      return _flushQueue();
    }));
  }

  Future<void> _flushQueue() async {
    final before = _queue.pendingCount;
    await _queue.flush(sender: (body) async {
      try {
        final res = await _api.postJson<Map<String, dynamic>>(
          RiskConfig.eventPath,
          body,
          parser: (d) => d as Map<String, dynamic>,
        );
        final ok = res.data != null;
        debugPrint(
            '[RiskGate] flush: POST ${RiskConfig.eventPath} eventType=${body['eventType']} '
            'adFormat=${body['adFormat']} -> ${ok ? 'ok' : 'failed(no data, code=${res.code}, message=${res.message})'}');
        return ok;
      } catch (e) {
        debugPrint('[RiskGate] flush: POST ${RiskConfig.eventPath} error: $e');
        return false;
      }
    });
    debugPrint(
        '[RiskGate] flush: done, pendingCount before=$before after=${_queue.pendingCount}');
  }

  Map<String, dynamic> _buildSignedBody({
    required String deviceId,
    required String eventType,
    required String adFormat,
    String? adSlotId,
    Map<String, dynamic>? signals,
  }) {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final nonce = const Uuid().v4();
    final signature = RiskSigner.sign(
      secret: RiskConfig.appSecret,
      deviceId: deviceId,
      timestamp: timestamp,
      nonce: nonce,
    );
    return {
      'deviceId': deviceId,
      if (adSlotId != null) 'adSlotId': adSlotId,
      'eventType': eventType,
      'adFormat': adFormat,
      'timestamp': timestamp,
      'nonce': nonce,
      'signature': signature,
      if (signals != null) 'signals': signals,
    };
  }

  @override
  void onClose() {
    _flushTimer?.cancel();
    super.onClose();
  }
}
