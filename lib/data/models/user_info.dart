/// 登录用户信息(对应接口 userInfo 对象,非 Hive 模型,仅 JSON 持久化)。
class UserInfo {
  final int id;
  final String username;
  final String nickname;
  final String? avatar;
  final String? phone;
  final String? email;

  const UserInfo({
    required this.id,
    required this.username,
    required this.nickname,
    this.avatar,
    this.phone,
    this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
        id: (json['id'] as num?)?.toInt() ?? 0,
        username: json['username'] as String? ?? '',
        nickname: json['nickname'] as String? ?? '',
        avatar: json['avatar'] as String?,
        phone: json['phone'] as String?,
        email: json['email'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'username': username,
        'nickname': nickname,
        'avatar': avatar,
        'phone': phone,
        'email': email,
      };
}
