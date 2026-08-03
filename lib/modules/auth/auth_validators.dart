/// 注册/登录表单本地校验,规则与接口文档一致。
/// 返回 null 表示通过,否则返回用户可读的错误提示。
class AuthValidators {
  static final _usernameRe = RegExp(r'^[A-Za-z0-9_]{3,50}$');
  static final _phoneRe = RegExp(r'^1\d{10}$');

  static String? username(String v) {
    if (v.isEmpty) return '请输入用户名';
    if (!_usernameRe.hasMatch(v)) return '用户名须为3-50个字符，仅限字母、数字、下划线';
    return null;
  }

  static String? password(String v) {
    if (v.isEmpty) return '请输入密码';
    if (v.length < 6 || v.length > 100) return '密码长度须为6-100个字符';
    return null;
  }

  static String? confirmPassword(String pwd, String confirm) {
    if (confirm != pwd) return '两次输入的密码不一致';
    return null;
  }

  static String? phone(String v) {
    if (v.isEmpty) return null;
    if (!_phoneRe.hasMatch(v)) return '手机号格式不正确';
    return null;
  }
}
