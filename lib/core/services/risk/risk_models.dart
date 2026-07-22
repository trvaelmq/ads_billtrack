/// 后端决策动作。未知取值/缺失一律按 pass 兜底(宁可漏拦不杀正常流量)。
enum RiskAction { pass, throttle, block, review, shadow }

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

/// POST /risk/decide 响应体 data 部分。
class DecisionResult {
  final RiskAction action;
  final double confidence;
  final String confidenceLevel;
  final List<String> hitRuleIds;
  final String requestId;
  final String reason;

  const DecisionResult({
    required this.action,
    required this.confidence,
    required this.confidenceLevel,
    required this.hitRuleIds,
    required this.requestId,
    required this.reason,
  });

  factory DecisionResult.fromJson(Map<String, dynamic> json) => DecisionResult(
        action: _actionFromString(json['action'] as String?),
        confidence: (json['confidence'] as num?)?.toDouble() ?? 0.0,
        confidenceLevel: json['confidenceLevel'] as String? ?? 'LOW',
        hitRuleIds:
            (json['hitRuleIds'] as List?)?.cast<String>() ?? const <String>[],
        requestId: json['requestId'] as String? ?? '',
        reason: json['reason'] as String? ?? 'NORMAL',
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
        type: json['type'] as String? ?? '',
        value: json['value'] as String? ?? '',
      );

  Map<String, dynamic> toJson() => {'type': type, 'value': value};

  /// 本地集合去重/查找用的复合 key。
  String get key => '$type:$value';
}
