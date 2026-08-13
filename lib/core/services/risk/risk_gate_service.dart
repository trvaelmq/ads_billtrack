import 'dart:io';
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

  /// 设备机型（如 iPhone14,2），供注册/登录接口透传。init() 完成前或获取失败时为 null。
  String? get deviceModel => _deviceSignals?['deviceModel'] as String?;

  /// 系统版本（如 iOS 17.4 / Android 14），供注册/登录接口透传。init() 完成前或获取失败时为 null。
  String? get systemVersion => _deviceSignals?['systemVersion'] as String?;

  /// 设备指纹 IDFV（仅 iOS 有值），供注册接口透传。init() 完成前或获取失败时为 null。
  String? get idfv => _deviceSignals?['idfv'] as String?;

  /// 是否越狱（仅基础检测，可被 hook 绕过），供注册接口透传。取不到时为 null。
  bool? get jailbroken => _deviceSignals?['jailbroken'] as bool?;

  /// 是否模拟器，供注册接口透传。取不到时为 null。
  bool? get emulator => _deviceSignals?['emulator'] as bool?;

  static const _method = MethodChannel(AdConfig.methodChannel);

  final ApiClient _api;
  final DeviceIdProvider _deviceIdProvider;

  String? _deviceId;
  // 机型/系统版本/是否插卡/运营商，设备生命周期内不会变，init() 时拉一次缓存。
  Map<String, dynamic>? _deviceSignals;

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
    if (_deviceSignals == null) {
      try {
        final raw = await _method.invokeMethod('getDeviceSignals');
        if (raw is Map) {
          _deviceSignals = raw.map((k, v) => MapEntry(k.toString(), v));
          debugPrint('[RiskGate] init: deviceSignals=$_deviceSignals');
        }
      } catch (e) {
        debugPrint('[RiskGate] getDeviceSignals failed: $e');
      }
    }
    return this;
  }

  /// 本机非回环 IPv4 地址，尽力而为（拿不到就不传，后端也能从请求头取）。
  Future<String?> _getLocalIp() async {
    try {
      final interfaces = await NetworkInterface.list(
        includeLoopback: false,
        type: InternetAddressType.IPv4,
      );
      for (final iface in interfaces) {
        for (final addr in iface.addresses) {
          if (!addr.isLoopback) {
            debugPrint('[RiskGate] getLocalIp: ${addr.address} (iface=${iface.name})');
            return addr.address;
          }
        }
      }
      debugPrint('[RiskGate] getLocalIp: no non-loopback IPv4 address found');
    } catch (e) {
      debugPrint('[RiskGate] getLocalIp failed: $e');
    }
    return null;
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

  /// 点击"看激励视频"前调用一次：调 /risk/check 决定当前是否可以看广告。
  /// 参数和响应形状与 [decideDetailed] 一致，额外带 resetInSeconds 倒计时
  /// （PASS 时为 45~90 随机值，STOP 时为距明日 0 点秒数），供本地冷却计时对齐后端。
  Future<DecisionResult> checkAdAvailability() {
    return _request(
      path: RiskConfig.checkPath,
      adSlotId: AdConfig.rewardedPosId,
      adFormat: RiskAdFormat.reward,
      eventType: RiskEventType.request,
    );
  }

  /// 激励视频看完时调用一次：调 /risk/event 决定是否放行奖励发放。
  /// BLOCK/THROTTLE 时调用方应跳过发奖励；其余动作视为可以发放。
  Future<DecisionResult> checkRewardCompletion() {
    return _request(
      path: RiskConfig.eventPath,
      adSlotId: AdConfig.rewardedPosId,
      adFormat: RiskAdFormat.reward,
      eventType: RiskEventType.view,
      extraSignals: const {'completionRate': 1.0},
    );
  }

  /// 拉取当前账号的广告观看记录（历史页用）。limit 默认 200，与后端一致。
  /// 请求失败/响应异常时抛异常，由调用方（HistoryController）决定如何提示。
  Future<AdViewRecordsResult> fetchAdViews({int limit = 200}) async {
    final res = await _api.getJson<Map<String, dynamic>>(
      RiskConfig.adViewsPath,
      query: {'limit': '$limit'},
      parser: (d) => d as Map<String, dynamic>,
    );
    if (!res.success) {
      throw Exception(
          'fetchAdViews failed: code=${res.code} message=${res.message}');
    }
    final data = res.data;
    if (data == null) {
      throw Exception('fetchAdViews: empty response data');
    }
    return AdViewRecordsResult.fromJson(data);
  }

  Future<DecisionResult> _request({
    required String path,
    required String adFormat,
    required String eventType,
    String? adSlotId,
    Map<String, dynamic>? extraSignals,
  }) async {
    final deviceId = _deviceId;
    debugPrint(
        '[RiskGate] request: path=$path adSlotId=$adSlotId adFormat=$adFormat eventType=$eventType deviceId=$deviceId');
    if (deviceId == null) {
      debugPrint('[RiskGate] request: deviceId unavailable -> fail-open pass');
      return DecisionResult.passFallback('DEVICE_ID_UNAVAILABLE');
    }

    final body = await _buildSignedBody(
      deviceId: deviceId,
      adSlotId: adSlotId,
      eventType: eventType,
      adFormat: adFormat,
      extraSignals: extraSignals,
    );
    try {
      final res = await _api.postJson<Map<String, dynamic>>(
        path,
        body,
        parser: (d) => d as Map<String, dynamic>,
      );
      if (!res.success) {
        throw Exception(
            'risk request failed: code=${res.code} message=${res.message}');
      }
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

  Future<Map<String, dynamic>> _buildSignedBody({
    required String deviceId,
    required String eventType,
    required String adFormat,
    String? adSlotId,
    Map<String, dynamic>? extraSignals,
  }) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final nonce = const Uuid().v4();
    final signature = RiskSigner.sign(
      secret: RiskConfig.appSecret,
      deviceId: deviceId,
      timestamp: timestamp,
      nonce: nonce,
    );
    final ip = await _getLocalIp();
    final deviceSignals = _deviceSignals;
    final signals = <String, dynamic>{
      // idfv：iOS 为真实 identifierForVendor（无需 ATT 授权）；Android 无此概念，取不到时不传。
      if (deviceSignals?['idfv'] != null) 'idfv': deviceSignals!['idfv'],
      // jailbroken/emulator：仅基础检测，取不到时不传，不强行兜底 false（避免误导风控）。
      if (deviceSignals?['jailbroken'] != null)
        'jailbroken': deviceSignals!['jailbroken'],
      if (deviceSignals?['emulator'] != null)
        'emulator': deviceSignals!['emulator'],
      if (deviceSignals?['deviceModel'] != null)
        'deviceModel': deviceSignals!['deviceModel'],
      if (deviceSignals?['systemVersion'] != null)
        'systemVersion': deviceSignals!['systemVersion'],
      // simPresent 是必填字段（api.md），getDeviceSignals 取不到时兜底传 false，不能整个省略。
      'simPresent': deviceSignals?['simPresent'] as bool? ?? false,
      if (deviceSignals?['simCarrier'] != null)
        'simCarrier': deviceSignals!['simCarrier'],
      if (extraSignals != null) ...extraSignals,
    };
    return {
      'deviceId': deviceId,
      if (ip != null) 'ip': ip,
      if (adSlotId != null) 'adSlotId': adSlotId,
      'eventType': eventType,
      'adFormat': adFormat,
      'timestamp': timestamp,
      'nonce': nonce,
      'signature': signature,
      'signals': signals,
    };
  }
}
