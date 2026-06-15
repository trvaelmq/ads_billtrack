import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/ad_config.dart';
import 'storage_service.dart';

class AdService extends GetxService {
  static AdService get to => Get.find();

  static const _method = MethodChannel(AdConfig.methodChannel);
  static const _event = EventChannel(AdConfig.eventChannel);

  final RxBool isRewardedReady = false.obs;
  final RxInt todayWatchCount = 0.obs; // 仅统计激励视频次数
  final RxInt totalCoins = 0.obs;
  final RxBool showCoinAnimation = false.obs;
  final RxInt lastEarnedCoins = 0.obs;
  final RxInt cooldownRemaining = 0.obs;
  Timer? _cooldownTimer;
  Timer? _preRewardedTimer;
  Timer? _postInterstitialTimer;

  // 流程阶段标记
  bool _interstitialIsPreRewarded = false; // 插屏是激励前置？关闭后弹激励
  bool _interstitialIsPostHistory = false; // 插屏是历史页后置？关闭后才返回
  bool _pendingHistoryBack = false; // 激励结束后跳历史，返回时弹插屏
  bool historyBackLocked = false; // 历史页返回锁，锁住期间忽略所有返回
  bool _rewardedFlowInProgress = false; // 激励流程进行中，忽略重复点击

  final _splashDone = Completer<void>();
  Future<void> get splashDone => _splashDone.future;

  @override
  void onInit() {
    super.onInit();
    debugPrint('[AdService] onInit');
    totalCoins.value = StorageService.totalCoins;
    todayWatchCount.value = StorageService.todayAdRecords.length;
    _event.receiveBroadcastStream().listen(_onAdEvent);
    loadRewardedAd();
  }

  Future<void> initAdSdk() async {
    try {
      await _method.invokeMethod('initAdSdk');
    } catch (e) {
      debugPrint('[AdService] initAdSdk error: $e');
    }
  }

  Future<void> showSplashAd() async {
    try {
      await _method.invokeMethod('showSplashAd', {
        'posId': AdConfig.splashPosId,
        'appId': AdConfig.appId,
      });
    } catch (e) {
      debugPrint('[AdService] showSplashAd error: $e');
    }
  }

  Future<void> dismissSplashAd() async {
    try {
      await _method.invokeMethod('dismissSplashAd');
    } catch (e) {
      debugPrint('[AdService] dismissSplashAd error: $e');
    }
  }

  Future<void> loadRewardedAd() async {
    isRewardedReady.value = false;
    try {
      await _method.invokeMethod('loadRewardedAd', {
        'posId': AdConfig.rewardedPosId,
        'appId': AdConfig.appId,
      });
    } catch (e) {
      debugPrint('[AdService] loadRewardedAd error: $e');
    }
  }

  Future<void> showRewardedAd() async {
    try {
      await _method.invokeMethod('showRewardedAd');
    } catch (e) {
      debugPrint('[AdService] showRewardedAd error: $e');
    }
  }

  Future<void> showInterstitialAd() async {
    try {
      await _method.invokeMethod('showInterstitialAd', {
        'posId': AdConfig.interstitialPosId,
        'appId': AdConfig.appId,
      });
    } catch (e) {
      debugPrint('[AdService] showInterstitialAd error: $e');
    }
  }

  Future<void> showFullScreenInterstitialAd() async {
    try {
      await _method.invokeMethod('showFullScreenInterstitialAd', {
        'posId': AdConfig.interstitialPosId,
        'appId': AdConfig.appId,
      });
    } catch (e) {
      debugPrint('[AdService] showFullScreenInterstitialAd error: $e');
    }
  }

  /// 随机 3~5 秒延迟，用于流程各节点之间的间隔
  Duration _randomDelay() => Duration(seconds: 3 + Random().nextInt(3));

  /// 点击"看激励视频"时调用：延迟3~5秒弹插屏，插屏关闭后再延迟3~5秒弹激励
  void startRewardedAdFlow() {
    if (_rewardedFlowInProgress) return; // 流程进行中，忽略重复点击
    _rewardedFlowInProgress = true;
    _interstitialIsPreRewarded = true;
    _preRewardedTimer = Timer(_randomDelay(), showInterstitialAd);
  }

  void _endRewardedFlow() {
    _rewardedFlowInProgress = false;
    _preRewardedTimer?.cancel();
    _postInterstitialTimer?.cancel();
  }

  /// 历史页返回时调用，消费一次"返回后弹插屏"标记，同时立即上锁
  bool consumeHistoryBackInterstitial() {
    final val = _pendingHistoryBack;
    _pendingHistoryBack = false;
    if (val) historyBackLocked = true;
    return val;
  }

  /// 历史页确认要弹后置插屏（延迟3~5秒后弹，弹完才返回）
  void showInterstitialForHistoryBack() {
    _interstitialIsPostHistory = true;
    _postInterstitialTimer?.cancel();
    _postInterstitialTimer = Timer(_randomDelay(), showInterstitialAd);
  }

  void _onAdEvent(dynamic data) {
    if (data is! Map) return;
    final type = data['type'] as String? ?? '';
    final event = data['event'] as String? ?? '';
    debugPrint('[AdService] event: $type.$event');

    switch ('$type.$event') {
      case 'rewarded.loaded':
      case 'rewarded.video_loaded':
        isRewardedReady.value = true;
        break;
      case 'rewarded.not_ready':
        isRewardedReady.value = false;
        _endRewardedFlow();
        loadRewardedAd();
        break;

      // 激励视频看完：记录 + 发金币（不在这里 reload，统一在 closed 里）
      case 'rewarded.rewarded':
        _recordRewarded();
        break;
      // 激励视频关闭（无论是否看完）：重新加载备用 + 跳历史页
      case 'rewarded.closed':
        _endRewardedFlow();
        loadRewardedAd();
        _pendingHistoryBack = true;
        Get.toNamed('/history');
        break;

      // 开屏：不记录、不发金币
      case 'splash.dismissed':
      case 'splash.failed':
        if (!_splashDone.isCompleted) _splashDone.complete();
        break;

      // 插屏关闭：前置 → 延迟300ms再弹激励；后置 → 解锁并真正返回
      case 'interstitial.dismissed':
        if (_interstitialIsPreRewarded) {
          _interstitialIsPreRewarded = false;
          _postInterstitialTimer?.cancel();
          _postInterstitialTimer = Timer(_randomDelay(), showRewardedAd);
        } else if (_interstitialIsPostHistory) {
          _interstitialIsPostHistory = false;
          historyBackLocked = false;
          Get.back();
        }
        break;

      // 插屏加载失败：前置 → 跳过直接弹激励；后置 → 解锁并直接返回
      case 'interstitial.failed':
        if (_interstitialIsPreRewarded) {
          _interstitialIsPreRewarded = false;
          if (isRewardedReady.value) {
            _postInterstitialTimer = Timer(_randomDelay(), showRewardedAd);
          } else {
            _endRewardedFlow(); // 插屏失败且激励不可用，流程结束
          }
        } else if (_interstitialIsPostHistory) {
          _interstitialIsPostHistory = false;
          historyBackLocked = false;
          Get.back();
        }
        break;
    }
  }

  Future<void> _recordRewarded() async {
    await StorageService.saveAdRecord('rewarded', AdConfig.rewardCoins);
    await StorageService.addCoins(AdConfig.rewardCoins);
    totalCoins.value = StorageService.totalCoins;
    todayWatchCount.value = StorageService.todayAdRecords.length;
    lastEarnedCoins.value = AdConfig.rewardCoins;
    showCoinAnimation.value = true;
    await Future.delayed(const Duration(milliseconds: 1500));
    showCoinAnimation.value = false;
    _startCooldown();
  }

  void _startCooldown() {
    _cooldownTimer?.cancel();
    final seconds = 45 + Random().nextInt(46); // 45~90 秒随机
    debugPrint('[AdService] cooldown started: ${seconds}s');
    cooldownRemaining.value = seconds;
    _cooldownTimer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (cooldownRemaining.value <= 0) {
        t.cancel();
      } else {
        cooldownRemaining.value--;
      }
    });
  }

  void refreshCoins() {
    totalCoins.value = StorageService.totalCoins;
  }

  @override
  void onClose() {
    _cooldownTimer?.cancel();
    _endRewardedFlow();
    super.onClose();
  }
}
