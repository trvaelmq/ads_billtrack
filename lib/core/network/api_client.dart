// lib/core/network/api_client.dart
import 'package:get/get.dart';
import 'api_config.dart';
import 'api_result.dart';

/// 统一网络客户端：自动附加 Bearer Token、统一响应解析、401 回调。
/// tokenProvider / onUnauthorized 由 AuthService 在初始化时注入。
class ApiClient extends GetConnect {
  String? Function()? tokenProvider;
  void Function()? onUnauthorized;

  @override
  void onInit() {
    httpClient.baseUrl = ApiConfig.baseUrl;
    httpClient.timeout = ApiConfig.timeout;
    httpClient.addRequestModifier<dynamic>((request) {
      final token = tokenProvider?.call();
      if (token != null && token.isNotEmpty) {
        request.headers['Authorization'] = 'Bearer $token';
      }
      return request;
    });
    super.onInit();
  }

  Future<ApiResult<T>> postJson<T>(
    String path,
    Map<String, dynamic>? body, {
    T Function(dynamic data)? parser,
  }) async {
    try {
      final resp = await post(path, body);
      return _handle(resp, parser);
    } catch (_) {
      return ApiResult<T>.networkError();
    }
  }

  Future<ApiResult<T>> getJson<T>(
    String path, {
    Map<String, dynamic>? query,
    T Function(dynamic data)? parser,
  }) async {
    try {
      final resp = await get(path, query: query);
      return _handle(resp, parser);
    } catch (_) {
      return ApiResult<T>.networkError();
    }
  }

  ApiResult<T> _handle<T>(Response resp, T Function(dynamic data)? parser) {
    final body = resp.body;
    if (body is! Map<String, dynamic>) return ApiResult<T>.networkError();
    final result = ApiResult<T>.fromJson(body, parser);
    if (result.code == 401) onUnauthorized?.call();
    return result;
  }
}
