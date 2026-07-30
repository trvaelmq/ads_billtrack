/// 风控 SDK 配置:接口路径、超时、AppSecret。
class RiskConfig {
  static const String appSecret = 'xiayuRiskADSlot';

  static const String decidePath = '/risk/decide';
  static const String eventPath = '/risk/event';
  static const String blacklistSyncPath = '/risk/blacklist/sync';

  /// 登录风控校验使用的 adSlotId，非广告位，用于在 /risk/decide 中区分"登录"场景。
  /// TODO(后端): 确认登录场景下 adSlotId/adFormat 的约定取值。
  static const String loginSlotId = 'LOGIN_GATE';

  /// 本地黑名单缓存过期时间,过期后下次同步 version 重置为 0 做全量刷新。
  static const Duration blacklistCacheTtl = Duration(hours: 24);

  /// 事件上报队列定时重试间隔。
  static const Duration eventQueueFlushInterval = Duration(seconds: 30);
}

/// 广告形态,对应后端 RiskEvent.adFormat 字段。
class RiskAdFormat {
  static const String reward = 'REWARD';
  static const String splash = 'SPLASH';
  static const String banner = 'BANNER';
  static const String feed = 'FEED';
  static const String interstitial = 'INTERSTITIAL';
  static const String login = 'LOGIN';
}

/// 事件类型,对应后端 RiskEvent.eventType 字段。
class RiskEventType {
  static const String request = 'REQUEST';
  static const String impression = 'IMPRESSION';
  static const String click = 'CLICK';
  static const String conversion = 'CONVERSION';
}
