struct AdConfig {
    static let appId             = "4582335cc3af56be" // 智探眼_iOS
    // posId 由 Flutter 端 ad_config.dart 统一管理，通过 MethodChannel 参数传入
    // 以下仅作回退兜底，正常不会用到
    static let splashPosId       = "99b82c48067f2084" // 智探眼_iOS-开屏
    static let rewardedPosId     = "bd569504ee7f0fcc" // 智探眼_iOS-激励视频
    static let bannerPosId       = "37a403bd9c243d90" // 智探眼_iOS-横幅
    static let interstitialPosId = "f39df5130e18f3d0" // 智探眼_iOS-插屏
    static let detailBannerPosId = "d6c5e2397e02e837" // 智探眼_iOS-原生混合
}

struct AdChannels {
    static let method = "com.billtrack/ad_method"
    static let event  = "com.billtrack/ad_event"
}
