import 'dart:io';

class AdConfig {
  // TODO(芒果平台): 以下均为占位值,ID 申请下发后替换
  // ── iOS(Mediatom)广告 ID ─────────────────────────────────────
  static const String _iosAppId              = '4582335cc3af56be'; // 智探眼_iOS
  static const String _iosSplashPosId        = '99b82c48067f2084'; // 智探眼_iOS-开屏
  static const String _iosRewardedPosId      = 'bd569504ee7f0fcc'; // 智探眼_iOS-激励视频
  static const String _iosBannerPosId        = '37a403bd9c243d90'; // 智探眼_iOS-横幅
  static const String _iosBannerHomePosId    = 'b0288c31dc859ebf'; // 智探眼_iOS-横幅-HOME
  static const String _iosInterstitialPosId  = 'f39df5130e18f3d0'; // 智探眼_iOS-插屏
  static const String _iosDetailBannerPosId  = 'd6c5e2397e02e837'; // 智探眼_iOS-原生混合

  // ── Android(MgMobi)广告 ID ───────────────────────────────────
  static const String _androidAppId             = 'e3a729330c8ca9a4'; // 智探眼_Android
  static const String _androidSplashPosId       = '198b01ffa638de2d'; // 智探眼_Android-开屏
  static const String _androidRewardedPosId     = 'd48de64ce7fa3da8'; // 智探眼_Android-激励视频
  static const String _androidBannerPosId       = '90b9d6c08cfdf27d'; // 智探眼_Android-横幅
  static const String _androidBannerHomePosId   = 'b01efa3d7e41ae5c'; // 智探眼_Android-横幅-HOME
  static const String _androidInterstitialPosId = '69f84f4e4aba54b1'; // 智探眼_Android-插屏
  static const String _androidDetailBannerPosId = 'c6d90d9e869f7098'; // 智探眼_Android-原生混合

  // ── 对外接口（自动按平台选择）────────────────────────────────────
  static String get appId             => Platform.isIOS ? _iosAppId             : _androidAppId;
  static String get splashPosId       => Platform.isIOS ? _iosSplashPosId       : _androidSplashPosId;
  static String get rewardedPosId     => Platform.isIOS ? _iosRewardedPosId     : _androidRewardedPosId;
  static String get bannerPosId       => Platform.isIOS ? _iosBannerPosId       : _androidBannerPosId;
  static String get bannerHomePosId   => Platform.isIOS ? _iosBannerHomePosId   : _androidBannerHomePosId;
  static String get interstitialPosId => Platform.isIOS ? _iosInterstitialPosId : _androidInterstitialPosId;
  static String get detailBannerPosId => Platform.isIOS ? _iosDetailBannerPosId : _androidDetailBannerPosId;

  // ── Flutter ↔ Native 通信通道 ────────────────────────────────────
  static const String methodChannel = 'com.billtrack/ad_method';
  static const String eventChannel  = 'com.billtrack/ad_event';
}
