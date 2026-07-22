import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/ad_config.dart';
import '../constants/risk_config.dart';
import 'risk/risk_gate_service.dart';
import 'risk/risk_models.dart';
import 'storage_service.dart';

class AdService extends GetxService {
  static AdService get to => Get.find();

  static const _method = MethodChannel(AdConfig.methodChannel);
  static const _event = EventChannel(AdConfig.eventChannel);

  final RxBool isRewardedReady = false.obs;
  final RxInt todayWatchCount = 0.obs; // 仅统计激励视频次数
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
  bool _rewardedLoadInFlight = false; // 激励加载进行中，防止并发重复调用

  final _splashDone = Completer<void>();
  Future<void> get splashDone => _splashDone.future;

  @override
  void onInit() {
    super.onInit();
    debugPrint('[AdService] onInit');
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
    final action = await RiskGateService.to.decide(
      adSlotId: AdConfig.splashPosId,
      adFormat: RiskAdFormat.splash,
    );
    if (action.isBlocked) {
      debugPrint('[AdService] showSplashAd blocked by risk gate: $action');
      if (!_splashDone.isCompleted) _splashDone.complete();
      return;
    }
    try {
      await _method.invokeMethod('showSplashAd', {
        'posId': AdConfig.splashPosId,
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
    if (_rewardedLoadInFlight) return;
    _rewardedLoadInFlight = true;
    try {
      isRewardedReady.value = false;
      final action = await RiskGateService.to.decide(
        adSlotId: AdConfig.rewardedPosId,
        adFormat: RiskAdFormat.reward,
      );
      if (action.isBlocked) {
        debugPrint('[AdService] loadRewardedAd blocked by risk gate: $action');
        return;
      }
      try {
        await _method.invokeMethod('loadRewardedAd', {
          'posId': AdConfig.rewardedPosId,
        });
      } catch (e) {
        debugPrint('[AdService] loadRewardedAd error: $e');
      }
    } finally {
      _rewardedLoadInFlight = false;
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
    final action = await RiskGateService.to.decide(
      adSlotId: AdConfig.interstitialPosId,
      adFormat: RiskAdFormat.interstitial,
    );
    if (action.isBlocked) {
      debugPrint('[AdService] showInterstitialAd blocked by risk gate: $action');
      _onInterstitialUnavailable();
      return;
    }
    try {
      await _method.invokeMethod('showInterstitialAd', {
        'posId': AdConfig.interstitialPosId,
      });
    } catch (e) {
      debugPrint('[AdService] showInterstitialAd error: $e');
    }
  }

  Future<void> showFullScreenInterstitialAd() async {
    final action = await RiskGateService.to.decide(
      adSlotId: AdConfig.interstitialPosId,
      adFormat: RiskAdFormat.interstitial,
    );
    if (action.isBlocked) {
      debugPrint(
          '[AdService] showFullScreenInterstitialAd blocked by risk gate: $action');
      _onInterstitialUnavailable();
      return;
    }
    try {
      await _method.invokeMethod('showFullScreenInterstitialAd', {
        'posId': AdConfig.interstitialPosId,
      });
    } catch (e) {
      debugPrint('[AdService] showFullScreenInterstitialAd error: $e');
    }
  }

  /// 固定 3 秒延迟，用于流程各节点之间的间隔
  Duration _randomDelay() => const Duration(seconds: 3);

  /// 点击"看激励视频"时调用：延迟3秒弹插屏，插屏关闭后再延迟3秒弹激励
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

  /// 历史页确认要弹后置插屏（延迟3秒后弹，弹完才返回）
  void showInterstitialForHistoryBack() {
    _interstitialIsPostHistory = true;
    _postInterstitialTimer?.cancel();
    _postInterstitialTimer = Timer(_randomDelay(), showInterstitialAd);
  }

  /// 插屏不可用(风控拦截 / 加载失败)时的统一收尾:维持现有前置/后置状态机不被卡死。
  void _onInterstitialUnavailable() {
    if (_interstitialIsPreRewarded) {
      _interstitialIsPreRewarded = false;
      if (isRewardedReady.value) {
        _postInterstitialTimer = Timer(_randomDelay(), showRewardedAd);
      } else {
        _endRewardedFlow();
      }
    } else if (_interstitialIsPostHistory) {
      _interstitialIsPostHistory = false;
      historyBackLocked = false;
      Get.back();
    }
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
      case 'rewarded.shown':
        try {
          RiskGateService.to.reportEvent(
              adFormat: RiskAdFormat.reward, eventType: RiskEventType.impression);
        } catch (e) {
          debugPrint('[AdService] reportEvent(rewarded.shown) error: $e');
        }
        break;
      case 'rewarded.clicked':
        try {
          RiskGateService.to.reportEvent(
              adFormat: RiskAdFormat.reward, eventType: RiskEventType.click);
        } catch (e) {
          debugPrint('[AdService] reportEvent(rewarded.clicked) error: $e');
        }
        break;

      // 激励视频看完：记录观看 + 启动冷却（不在这里 reload，统一在 closed 里）
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

      // 开屏：不记录
      case 'splash.dismissed':
      case 'splash.failed':
        if (!_splashDone.isCompleted) _splashDone.complete();
        break;
      case 'splash.shown':
        try {
          RiskGateService.to.reportEvent(
              adFormat: RiskAdFormat.splash, eventType: RiskEventType.impression);
        } catch (e) {
          debugPrint('[AdService] reportEvent(splash.shown) error: $e');
        }
        break;
      case 'splash.clicked':
        try {
          RiskGateService.to.reportEvent(
              adFormat: RiskAdFormat.splash, eventType: RiskEventType.click);
        } catch (e) {
          debugPrint('[AdService] reportEvent(splash.clicked) error: $e');
        }
        break;

      case 'interstitial.shown':
        try {
          RiskGateService.to.reportEvent(
              adFormat: RiskAdFormat.interstitial, eventType: RiskEventType.impression);
        } catch (e) {
          debugPrint('[AdService] reportEvent(interstitial.shown) error: $e');
        }
        break;
      case 'interstitial.clicked':
        try {
          RiskGateService.to.reportEvent(
              adFormat: RiskAdFormat.interstitial, eventType: RiskEventType.click);
        } catch (e) {
          debugPrint('[AdService] reportEvent(interstitial.clicked) error: $e');
        }
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
        _onInterstitialUnavailable();
        break;
    }
  }

  Future<void> _recordRewarded() async {
    await StorageService.saveAdRecord('rewarded');
    todayWatchCount.value = StorageService.todayAdRecords.length;
    RiskGateService.to.reportEvent(
      adFormat: RiskAdFormat.reward,
      eventType: RiskEventType.conversion,
      signals: {'completionRate': 1.0},
    );
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

  @override
  void onClose() {
    _cooldownTimer?.cancel();
    _endRewardedFlow();
    super.onClose();
  }
}
