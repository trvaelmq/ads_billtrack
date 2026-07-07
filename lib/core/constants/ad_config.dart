import 'dart:io';

class AdConfig {
  // TODO(芒果平台): 以下均为占位值,ID 申请下发后替换
  // ── iOS(Mediatom)广告 ID ─────────────────────────────────────
  static const String _iosAppId              = 'MG_IOS_APP_ID_TODO';
  static const String _iosSplashPosId        = 'MG_IOS_SPLASH_POS_ID_TODO';
  static const String _iosRewardedPosId      = 'MG_IOS_REWARDED_POS_ID_TODO';
  static const String _iosBannerPosId        = 'MG_IOS_BANNER_POS_ID_TODO';
  static const String _iosInterstitialPosId  = 'MG_IOS_INTERSTITIAL_POS_ID_TODO';
  static const String _iosDetailBannerPosId  = 'MG_IOS_NATIVE_POS_ID_TODO';

  // ── Android(MgMobi)广告 ID ───────────────────────────────────
  static const String _androidAppId             = 'MG_APP_ID_TODO';
  static const String _androidSplashPosId       = 'MG_SPLASH_POS_ID_TODO';
  static const String _androidRewardedPosId     = 'MG_REWARDED_POS_ID_TODO';
  static const String _androidBannerPosId       = 'MG_BANNER_POS_ID_TODO';
  static const String _androidInterstitialPosId = 'MG_INTERSTITIAL_POS_ID_TODO';
  static const String _androidDetailBannerPosId = 'MG_NATIVE_POS_ID_TODO';

  // ── 对外接口（自动按平台选择）────────────────────────────────────
  static String get appId             => Platform.isIOS ? _iosAppId             : _androidAppId;
  static String get splashPosId       => Platform.isIOS ? _iosSplashPosId       : _androidSplashPosId;
  static String get rewardedPosId     => Platform.isIOS ? _iosRewardedPosId     : _androidRewardedPosId;
  static String get bannerPosId       => Platform.isIOS ? _iosBannerPosId       : _androidBannerPosId;
  static String get interstitialPosId => Platform.isIOS ? _iosInterstitialPosId : _androidInterstitialPosId;
  static String get detailBannerPosId => Platform.isIOS ? _iosDetailBannerPosId : _androidDetailBannerPosId;

  // ── Flutter ↔ Native 通信通道 ────────────────────────────────────
  static const String methodChannel = 'com.billtrack/ad_method';
  static const String eventChannel  = 'com.billtrack/ad_event';
}
