// lib/core/network/api_config.dart
/// 后端服务地址集中配置:切换环境只改这里。
/// - 线上服务器:http://116.62.215.148:8080
/// - 本机调试(iOS 模拟器/桌面):http://localhost:8080
/// - Android 模拟器访问宿主机本地服务:http://10.0.2.2:8080
class ApiConfig {
  static const String baseUrl = 'http://116.62.215.148:8080';
  static const Duration timeout = Duration(seconds: 10);
}
