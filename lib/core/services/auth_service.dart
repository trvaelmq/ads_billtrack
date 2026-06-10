import 'package:get/get.dart';
import '../../data/models/user_info.dart';
import '../network/api_client.dart';
import '../network/api_result.dart';
import 'storage_service.dart';

/// 认证服务：登录状态、token 持久化、认证接口业务封装。
/// 登录为可选能力，未登录不影响任何本地功能。
class AuthService extends GetxService {
  static AuthService get to => Get.find();

  final ApiClient _api;
  AuthService(this._api);

  final isLoggedIn = false.obs;
  final userInfo = Rxn<UserInfo>();

  String? _token;

  @override
  void onInit() {
    super.onInit();
    _api.tokenProvider = () => _token;
    _api.onUnauthorized = _clearLocal;
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
    String? email,
    String? nickname,
  }) async {
    final body = <String, dynamic>{
      'username': username,
      'password': password,
      if (phone != null && phone.isNotEmpty) 'phone': phone,
      if (email != null && email.isNotEmpty) 'email': email,
      if (nickname != null && nickname.isNotEmpty) 'nickname': nickname,
    };
    final result = await _api.postJson<void>('/api/auth/register', body);
    if (!result.success) return result;
    return login(username, password);
  }

  Future<ApiResult<void>> login(String username, String password) async {
    final result = await _api.postJson<Map<String, dynamic>>(
      '/api/auth/login',
      {'username': username, 'password': password},
      parser: (d) => d as Map<String, dynamic>,
    );
    if (!result.success || result.data == null) {
      return ApiResult(code: result.code, message: result.message);
    }
    final data = result.data!;
    _token = data['token'] as String;
    final info = UserInfo.fromJson(data['userInfo'] as Map<String, dynamic>);
    userInfo.value = info;
    isLoggedIn.value = true;
    await StorageService.setAuthToken(_token!);
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

  void _clearLocal() {
    _token = null;
    userInfo.value = null;
    isLoggedIn.value = false;
    StorageService.clearAuth();
  }
}
