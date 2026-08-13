import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/user_info.dart';
import '../../router/app_pages.dart';
import '../constants/risk_config.dart';
import '../network/api_client.dart';
import '../network/api_result.dart';
import 'ad_service.dart';
import 'risk/risk_gate_service.dart';
import 'risk/risk_models.dart';
import 'storage_service.dart';

/// 认证服务：登录状态、token 持久化、认证接口业务封装。
/// 登录可选：游客可直接使用，写入/输出操作前经 ensureLoggedIn 按需登录。
class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final ApiClient _api;
  AuthService(this._api);

  final isLoggedIn = false.obs;
  final userInfo = Rxn<UserInfo>();

  /// 登录时命中风控 STOP（不拦截登录，仅提示）时的后端文案，登录成功后展示一次。
  final riskStopMessage = Rxn<String>();

  String? _token;

  /// 与风控 SDK 用同一个 deviceId，注册/登录时透传给后端，
  /// 用于按 deviceId 关联广告观看数。RiskGateService 未就绪时为 null。
  String? get _deviceId =>
      Get.isRegistered<RiskGateService>() ? RiskGateService.to.deviceId : null;

  /// 设备机型，注册/登录时透传给后端。RiskGateService 未就绪时为 null。
  String? get _deviceModel =>
      Get.isRegistered<RiskGateService>() ? RiskGateService.to.deviceModel : null;

  /// 系统版本，注册/登录时透传给后端；原生侧只给纯数字（如 17.4），这里按平台拼成
  /// "iOS 17.4" / "Android 14"，避免后端拿到裸数字分不清平台。RiskGateService 未就绪时为 null。
  String? get _systemVersion {
    if (!Get.isRegistered<RiskGateService>()) return null;
    final version = RiskGateService.to.systemVersion;
    if (version == null) return null;
    if (Platform.isIOS) return 'iOS $version';
    if (Platform.isAndroid) return 'Android $version';
    return version;
  }

  /// 设备指纹 IDFV（仅 iOS 有值），注册时透传。RiskGateService 未就绪时为 null。
  String? get _idfv =>
      Get.isRegistered<RiskGateService>() ? RiskGateService.to.idfv : null;

  /// 是否越狱，注册时透传。RiskGateService 未就绪时为 null。
  bool? get _jailbroken =>
      Get.isRegistered<RiskGateService>() ? RiskGateService.to.jailbroken : null;

  /// 是否模拟器，注册时透传。RiskGateService 未就绪时为 null。
  bool? get _emulator =>
      Get.isRegistered<RiskGateService>() ? RiskGateService.to.emulator : null;

  @override
  void onInit() {
    super.onInit();
    _api.tokenProvider = () => _token;
    _api.onUnauthorized = _onUnauthorized;
    _restore();
  }

  /// 从本地恢复登录态（不校验有效性，校验由 validateOnLaunch 完成）
  void _restore() {
    final token = StorageService.authToken;
    final info = StorageService.authUserInfo;
    if (token != null && info != null) {
      _token = token;
      userInfo.value = UserInfo.fromJson(info);
      isLoggedIn.value = true;
    }
  }

  /// 启动时静默校验 token：成功刷新用户信息；401 清登录态（经 onUnauthorized 回调）；
  /// 网络异常保留本地缓存，不打扰用户。
  Future<void> validateOnLaunch() async {
    if (_token == null) return;
    try {
      final result = await _api.getJson<UserInfo>(
        '/api/auth/me',
        parser: (d) => UserInfo.fromJson(d as Map<String, dynamic>),
      );
      if (result.success && result.data != null) {
        userInfo.value = result.data;
        await StorageService.setAuthUserInfo(result.data!.toJson());
      }
    } catch (_) {
      // 网络异常：保留本地登录态
    }
  }

  /// 注册；成功后自动用相同凭据登录。
  Future<ApiResult<void>> register({
    required String username,
    required String password,
    String? phone,
    String? invitationCode,
  }) async {
    final body = <String, dynamic>{
      'username': username,
      'password': password,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (invitationCode != null && invitationCode.isNotEmpty)
        'invitationCode': invitationCode,
      if (_deviceId != null) 'deviceId': _deviceId,
      if (_deviceModel != null) 'deviceModel': _deviceModel,
      if (_systemVersion != null) 'systemVersion': _systemVersion,
      if (_idfv != null) 'idfv': _idfv,
      if (_jailbroken != null) 'jailbroken': _jailbroken,
      if (_emulator != null) 'emulator': _emulator,
    };
    final result = await _api.postJson<void>('/api/auth/register', body);
    if (!result.success) return result;
    final loginResult = await login(username, password);
    if (!loginResult.success) {
      return ApiResult(
          code: loginResult.code, message: '注册成功，自动登录失败，请手动登录');
    }
    final newUserId = userInfo.value?.id;
    if (newUserId != null) await _maybeStartPostRegistrationCooldown(newUserId);
    return loginResult;
  }

  /// 注册并自动登录成功后触发一次的广告冷却（R6）：仅注册流程触发，普通登录不受影响；
  /// 按 userId 记本地 flag 防止重复触发，AdService 未就绪时静默跳过。
  Future<void> _maybeStartPostRegistrationCooldown(int userId) async {
    if (!Get.isRegistered<AdService>()) return;
    final flagKey = 'post_reg_cooldown_$userId';
    if (StorageService.hasFlag(flagKey)) return;
    await StorageService.setFlag(flagKey);
    AdService.to.startPostRegistrationCooldown();
  }

  /// 操作前登录闸门：已登录直接放行；未登录弹确认框，
  /// 用户选择去登录并登录成功后返回 true，否则返回 false。
  Future<bool> ensureLoggedIn(
      {String message = '此操作需要登录后才能使用，是否前往登录？'}) async {
    if (isLoggedIn.value) return true;
    final go = await Get.dialog<bool>(AlertDialog(
      title: const Text('需要登录'),
      content: Text(message),
      actions: [
        TextButton(
            onPressed: () => Get.back(result: false), child: const Text('取消')),
        TextButton(
            onPressed: () => Get.back(result: true), child: const Text('去登录')),
      ],
    ));
    if (go != true) return false;
    await Get.toNamed(Routes.login);
    return isLoggedIn.value;
  }

  /// 点登录按钮时先做风控校验：命中 BLOCK/THROTTLE 直接拦截，不发登录请求；
  /// 命中 STOP 不拦截登录，只记下文案供登录成功后提示一次；
  /// 风控服务未就绪或异常一律降级放行（不阻断正常登录）。
  Future<ApiResult<void>?> _riskGateLogin() async {
    riskStopMessage.value = null;
    if (!Get.isRegistered<RiskGateService>()) return null;
    final result = await RiskGateService.to.decideDetailed(
      adSlotId: RiskConfig.loginSlotId,
      adFormat: RiskAdFormat.login,
    );
    if (result.action == RiskAction.stop) {
      riskStopMessage.value = result.message ?? '当前操作触发风控限制';
    }
    if (!result.action.isBlocked) return null;
    return ApiResult(code: -1, message: result.message ?? '登录失败，请稍后重试');
  }

  Future<ApiResult<void>> login(String username, String password) async {
    final riskBlock = await _riskGateLogin();
    if (riskBlock != null) return riskBlock;
    final result = await _api.postJson<Map<String, dynamic>>(
      '/api/auth/login',
      {
        'username': username,
        'password': password,
        if (_deviceId != null) 'deviceId': _deviceId,
        if (_deviceModel != null) 'deviceModel': _deviceModel,
        if (_systemVersion != null) 'systemVersion': _systemVersion,
        if (_idfv != null) 'idfv': _idfv,
        if (_jailbroken != null) 'jailbroken': _jailbroken,
        if (_emulator != null) 'emulator': _emulator,
      },
      parser: (d) => d as Map<String, dynamic>,
    );
    if (!result.success || result.data == null) {
      return ApiResult(code: result.code, message: result.message);
    }
    final data = result.data!;
    final token = data['token'] as String?;
    final userJson = data['userInfo'];
    if (token == null || token.isEmpty || userJson is! Map<String, dynamic>) {
      return ApiResult(code: -1, message: '服务端响应异常，请稍后重试');
    }
    _token = token;
    final info = UserInfo.fromJson(userJson);
    userInfo.value = info;
    isLoggedIn.value = true;
    await StorageService.setAuthToken(token);
    await StorageService.setAuthUserInfo(info.toJson());
    return ApiResult(code: result.code, message: result.message);
  }

  /// 退出登录：尽力通知服务端，无论成败都清除本地登录态（不动本地记账数据）。
  Future<void> logout() async {
    if (_token != null) {
      try {
        await _api.postJson<void>('/api/auth/logout', null);
      } catch (_) {
        // 忽略：本地登录态照常清除
      }
    }
    _clearLocal();
  }

  /// 注销账号：真正使账号失效（区别于 [logout] 退出登录），成功后清本地登录态。
  Future<ApiResult<void>> cancelAccount() async {
    final result = await _api.getJson<void>('/api/auth/cancel');
    if (result.success) _clearLocal();
    return result;
  }

  void _clearLocal() {
    _token = null;
    userInfo.value = null;
    isLoggedIn.value = false;
    StorageService.clearAuth();
  }

  /// token 失效（401）回调：仅清本地登录态，不再强制跳转登录页。
  void _onUnauthorized() {
    _clearLocal();
  }
}
