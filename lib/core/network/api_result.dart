/// 后端统一响应 {code, message, data} 的解析结果。
class ApiResult<T> {
  final int code;
  final String message;
  final T? data;

  const ApiResult({required this.code, required this.message, this.data});

  bool get success => code == 200;

  factory ApiResult.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic data)? parser,
  ) {
    final raw = json['data'];
    return ApiResult(
      code: json['code'] as int? ?? -1,
      message: json['message'] as String? ?? '未知错误',
      data: (raw != null && parser != null) ? parser(raw) : null,
    );
  }

  // 注意:不能写 const —— 泛型类的常量构造不能引用类型参数 T
  factory ApiResult.networkError() =>
      ApiResult(code: -1, message: '网络连接失败，请检查网络');
}
