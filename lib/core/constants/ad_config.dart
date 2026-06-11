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
  static const String _androidAppId             = '1218204331';
  static const String _androidSplashPosId       = '8342838010044490';
  static const String _androidRewardedPosId     = '7372230060751854';
  static const String _androidBannerPosId       = '5332138080267019';
  static const String _androidInterstitialPosId = '4332831030150879';
  static const String _androidDetailBannerPosId = '6332032080264311';

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

  // ── 金币奖励 ─────────────────────────────────────────────────────
  static const int rewardCoins        = 30; // 激励视频
  static const int splashCoins        = 3;  // 开屏广告
  static const int interstitialCoins  = 8;  // 插屏广告
  static const int checkinCoins       = 5;  // 每日签到
  static const int checkinStreakBonus = 20; // 7连签奖励

  static const int dailyRewardedLimit = 10;
}
