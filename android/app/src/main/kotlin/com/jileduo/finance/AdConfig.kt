package com.jileduo.finance

internal object AdConfig {
    // posId 以 Flutter 端 ad_config.dart 为准(经 MethodChannel 传入),下方仅回退兜底
    const val APP_ID               = "e3a729330c8ca9a4" // 智探眼_Android
    const val CHANNEL              = "default"
    const val SPLASH_POS_ID        = "198b01ffa638de2d" // 智探眼_Android-开屏
    const val REWARDED_POS_ID      = "d48de64ce7fa3da8" // 智探眼_Android-激励视频
    const val BANNER_POS_ID        = "90b9d6c08cfdf27d" // 智探眼_Android-横幅
    const val INTERSTITIAL_POS_ID  = "69f84f4e4aba54b1" // 智探眼_Android-插屏
    const val DETAIL_BANNER_POS_ID = "c6d90d9e869f7098" // 智探眼_Android-原生混合
}
