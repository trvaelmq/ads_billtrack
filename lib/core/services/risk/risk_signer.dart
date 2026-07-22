import 'dart:convert';
import 'package:crypto/crypto.dart';

/// 与后端 byte 级对齐的请求签名:
/// HMAC-SHA256(key=AppSecret, data=deviceId+"|"+timestamp+"|"+nonce).hex()，hex 小写。
class RiskSigner {
  static String sign({
    required String secret,
    required String deviceId,
    required int timestamp,
    required String nonce,
  }) {
    final data = '$deviceId|$timestamp|$nonce';
    final hmac = Hmac(sha256, utf8.encode(secret));
    return hmac.convert(utf8.encode(data)).toString();
  }
}
