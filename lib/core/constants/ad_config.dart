import 'dart:io';

class AdConfig {
  // ── iOS 广告 ID ──────────────────────────────────────────────────
  static const String _iosAppId             = '1216302675';
  static const String _iosSplashPosId       = '8209410871679575';
  static const String _iosRewardedPosId     = '2219411821577645';
  static const String _iosBannerPosId       = '2229514851277719';
  static const String _iosInterstitialPosId    = '5249065638219372';
  static const String _iosDetailBannerPosId    = '3209363984768765';

  // ── Android 广告 ID ──────────────────────────────────────────────
  static const String _androidAppId             = '1216276718';
  static const String _androidSplashPosId       = '2269612550960760';
  static const String _androidRewardedPosId     = '3259218520662808';
  static const String _androidBannerPosId       = '1219512560072270';
  static const String _androidInterstitialPosId = '5269645752095955';
  static const String _androidDetailBannerPosId = '2321251085406479';

  // ── 对外接口（自动按平台选择）────────────────────────────────────
  static String get appId             => Platform.isIOS ? _iosAppId             : _androidAppId;
  static String get splashPosId       => Platform.isIOS ? _iosSplashPosId       : _androidSplashPosId;
  static String get rewardedPosId     => Platform.isIOS ? _iosRewardedPosId     : _androidRewardedPosId;
  static String get bannerPosId       => Platform.isIOS ? _iosBannerPosId       : _androidBannerPosId;
  static String get interstitialPosId => Platform.isIOS ? _iosInterstitialPosId : _androidInterstitialPosId;
  static String get detailBannerPosId => Platform.isIOS ? _iosDetailBannerPosId : _androidDetailBannerPosId;

  // ── 竞价底价（分/千次）─────────────────────────────────────────
  // 0 = 不过滤（任意 eCPM>=0 即竞胜）。eCPM<=0（未配竞价位/取不到价）时原生会跳过竞价正常展示。
  // 待真机调优后填真实值。
  static const int _iosSplashFloor       = 0;
  static const int _iosRewardedFloor     = 0;
  static const int _iosInterstitialFloor = 0;
  static const int _iosBannerFloor       = 0;
  static const int _iosNativeFloor       = 0;

  static const int _androidSplashFloor       = 0;
  static const int _androidRewardedFloor     = 0;
  static const int _androidInterstitialFloor = 0;
  static const int _androidBannerFloor       = 0;
  static const int _androidNativeFloor       = 0;

  static int get splashFloor       => Platform.isIOS ? _iosSplashFloor       : _androidSplashFloor;
  static int get rewardedFloor     => Platform.isIOS ? _iosRewardedFloor     : _androidRewardedFloor;
  static int get interstitialFloor => Platform.isIOS ? _iosInterstitialFloor : _androidInterstitialFloor;
  static int get bannerFloor       => Platform.isIOS ? _iosBannerFloor       : _androidBannerFloor;
  static int get nativeFloor       => Platform.isIOS ? _iosNativeFloor       : _androidNativeFloor;

  // ── Flutter ↔ Native 通信通道 ────────────────────────────────────
  static const String methodChannel = 'com.billtrack/ad_method';
  static const String eventChannel  = 'com.billtrack/ad_event';

}
