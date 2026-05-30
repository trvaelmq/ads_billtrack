struct AdConfig {
    static let appId             = "1216302675"
    // posId 由 Flutter 端 ad_config.dart 统一管理，通过 MethodChannel 参数传入
    // 以下仅作回退兜底，正常不会用到
    static let splashPosId       = "8209410871679575"
    static let rewardedPosId     = "2219411821577645"
    static let bannerPosId       = "2229514851277719"
    static let interstitialPosId = "5249065638219372"
}

struct AdChannels {
    static let method = "com.billtrack/ad_method"
    static let event  = "com.billtrack/ad_event"
}
