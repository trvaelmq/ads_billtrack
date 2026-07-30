import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../constants/ad_config.dart';
import '../../constants/risk_config.dart';
import '../../network/api_client.dart';
import 'risk_models.dart';
import 'risk_signer.dart';

typedef DeviceIdProvider = Future<String?> Function();

/// 风控网关唯一对外入口，只覆盖两个场景：登录时决策拦截、激励视频看完后决定是否发奖励。
class RiskGateService extends GetxService {
  static RiskGateService get to => Get.find();

  /// 当前设备唯一标识，供注册/登录接口透传，与 /risk/decide、/risk/event 用同一个 deviceId
  /// 才能按 deviceId 关联观看数据。init() 完成前或获取失败时为 null。
  String? get deviceId => _deviceId;

  static const _method = MethodChannel(AdConfig.methodChannel);

  final ApiClient _api;
  final DeviceIdProvider _deviceIdProvider;

  String? _deviceId;

  RiskGateService({
    required ApiClient api,
    DeviceIdProvider? deviceIdProvider,
  })  : _api = api,
        _deviceIdProvider = deviceIdProvider ??
            (() => _method.invokeMethod<String>('getDeviceId'));

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
    return this;
  }

  /// 登录点击前调用。超时/异常/解析失败一律本地降级为 pass，不阻断正常登录。
  Future<RiskAction> decide({
    required String adSlotId,
    required String adFormat,
  }) async {
    final result = await decideDetailed(adSlotId: adSlotId, adFormat: adFormat);
    return result.action;
  }

  /// 与 [decide] 逻辑一致，但返回完整 [DecisionResult]（含 BLOCK 时的拦截文案 message），
  /// 供登录场景向用户展示后端拦截原因。
  Future<DecisionResult> decideDetailed({
    required String adSlotId,
    required String adFormat,
  }) async {
    return _request(
      path: RiskConfig.decidePath,
      adSlotId: adSlotId,
      adFormat: adFormat,
      eventType: RiskEventType.request,
    );
  }

  /// 激励视频看完时调用一次：调 /risk/event 决定是否放行奖励发放。
  /// BLOCK/THROTTLE 时调用方应跳过发奖励；其余动作视为可以发放。
  Future<DecisionResult> checkRewardCompletion() {
    return _request(
      path: RiskConfig.eventPath,
      adFormat: RiskAdFormat.reward,
      eventType: RiskEventType.conversion,
      signals: const {'completionRate': 1.0},
    );
  }

  Future<DecisionResult> _request({
    required String path,
    required String adFormat,
    required String eventType,
    String? adSlotId,
    Map<String, dynamic>? signals,
  }) async {
    final deviceId = _deviceId;
    debugPrint(
        '[RiskGate] request: path=$path adSlotId=$adSlotId adFormat=$adFormat eventType=$eventType deviceId=$deviceId');
    if (deviceId == null) {
      debugPrint('[RiskGate] request: deviceId unavailable -> fail-open pass');
      return DecisionResult.passFallback('DEVICE_ID_UNAVAILABLE');
    }

    final body = _buildSignedBody(
      deviceId: deviceId,
      adSlotId: adSlotId,
      eventType: eventType,
      adFormat: adFormat,
      signals: signals,
    );
    try {
      final res = await _api.postJson<Map<String, dynamic>>(
        path,
        body,
        parser: (d) => d as Map<String, dynamic>,
      );
      final data = res.data;
      if (data == null) {
        debugPrint(
            '[RiskGate] request: empty response data (code=${res.code}, message=${res.message}) -> fail-open pass');
        return DecisionResult.passFallback('EMPTY_RESPONSE');
      }
      final result = DecisionResult.fromJson(data);
      debugPrint(
          '[RiskGate] request: result action=${result.action} reason=${result.reason} '
          'confidence=${result.confidence}/${result.confidenceLevel} requestId=${result.requestId}');
      return result;
    } catch (e) {
      debugPrint('[RiskGate] request failed, fallback pass: $e');
      return DecisionResult.passFallback('CLIENT_ERROR');
    }
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
}
