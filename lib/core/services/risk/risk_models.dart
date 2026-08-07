/// 后端决策动作。未知取值/缺失一律按 pass 兜底(宁可漏拦不杀正常流量)。
enum RiskAction { pass, throttle, block, review, shadow, stop }

extension RiskActionX on RiskAction {
  /// BLOCK/THROTTLE 视为拦截:调用方应跳过联盟广告 SDK。
  bool get isBlocked => this == RiskAction.block || this == RiskAction.throttle;
}

RiskAction _actionFromString(String? raw) {
  switch (raw) {
    case 'BLOCK':
      return RiskAction.block;
    case 'THROTTLE':
      return RiskAction.throttle;
    case 'STOP':
      return RiskAction.stop;
    case 'REVIEW':
      return RiskAction.review;
    case 'SHADOW':
      return RiskAction.shadow;
    case 'PASS':
      return RiskAction.pass;
    default:
      return RiskAction.pass;
  }
}

/// 从 Map 中防御性地读取字符串字段:类型不符或缺失一律返回 null,不抛异常。
String? _str(Map<String, dynamic> json, String key) {
  final v = json[key];
  return v is String ? v : null;
}

/// POST /risk/decide 响应体 data 部分。
class DecisionResult {
  final RiskAction action;
  final double confidence;
  final String confidenceLevel;
  final List<String> hitRuleIds;
  final String requestId;
  final String reason;
  final String? message;
  /// 距离下次可用的倒计时（秒）：STOP 时为距明日 0 点秒数，PASS 时为 45~90 随机值。
  /// 由 /risk/check、/risk/event 返回；旧接口/未升级前为 null。
  final int? resetInSeconds;

  const DecisionResult({
    required this.action,
    required this.confidence,
    required this.confidenceLevel,
    required this.hitRuleIds,
    required this.requestId,
    required this.reason,
    this.message,
    this.resetInSeconds,
  });

  factory DecisionResult.fromJson(Map<String, dynamic> json) => DecisionResult(
        action: _actionFromString(_str(json, 'action')),
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
        confidenceLevel: _str(json, 'confidenceLevel') ?? 'LOW',
        hitRuleIds: (json['hitRuleIds'] as List?)
                ?.whereType<String>()
                .toList() ??
            const <String>[],
        requestId: _str(json, 'requestId') ?? '',
        reason: _str(json, 'reason') ?? 'NORMAL',
        message: _str(json, 'message'),
        resetInSeconds: (json['resetInSeconds'] as num?)?.toInt(),
      );

  /// 网络异常/超时/签名失败时的本地降级结果。
  factory DecisionResult.passFallback(String reason) => DecisionResult(
        action: RiskAction.pass,
        confidence: 0.0,
        confidenceLevel: 'LOW',
        hitRuleIds: const <String>[],
        requestId: '',
        reason: reason,
      );
}

/// GET /risk/blacklist/sync 响应体 data.items 里的一项。
class BlacklistItem {
  final String type; // DEVICE|IP|FINGERPRINT|SUBNET
  final String value;

  const BlacklistItem({required this.type, required this.value});

  factory BlacklistItem.fromJson(Map<String, dynamic> json) => BlacklistItem(
        type: _str(json, 'type') ?? '',
        value: _str(json, 'value') ?? '',
      );

  Map<String, dynamic> toJson() => {'type': type, 'value': value};

  /// 本地集合去重/查找用的复合 key。
  String get key => '$type:$value';
}
