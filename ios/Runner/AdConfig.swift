struct AdConfig {
    // TODO(芒果平台): 以下均为占位值,ID 申请下发后替换
    static let appId             = "MG_IOS_APP_ID_TODO"
    // posId 由 Flutter 端 ad_config.dart 统一管理，通过 MethodChannel 参数传入
    // 以下仅作回退兜底，正常不会用到
    static let splashPosId       = "MG_IOS_SPLASH_POS_ID_TODO"
    static let rewardedPosId     = "MG_IOS_REWARDED_POS_ID_TODO"
    static let bannerPosId       = "MG_IOS_BANNER_POS_ID_TODO"
    static let interstitialPosId = "MG_IOS_INTERSTITIAL_POS_ID_TODO"
}

struct AdChannels {
    static let method = "com.billtrack/ad_method"
    static let event  = "com.billtrack/ad_event"
}
