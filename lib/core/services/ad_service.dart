import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/ad_config.dart';
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
    try {
      await _method.invokeMethod('showInterstitialAd', {
        'posId': AdConfig.interstitialPosId,
      });
    } catch (e) {
      debugPrint('[AdService] showInterstitialAd error: $e');
    }
  }

  Future<void> showFullScreenInterstitialAd() async {
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

  /// 插屏不可用(风控拦截 / 加载失败)时的统一收尾:维持现有前置状态机不被卡死。
  void _onInterstitialUnavailable() {
    if (_interstitialIsPreRewarded) {
      _interstitialIsPreRewarded = false;
      if (isRewardedReady.value) {
        _postInterstitialTimer = Timer(_randomDelay(), showRewardedAd);
      } else {
        _endRewardedFlow();
      }
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
      // 激励视频看完：先问一次风控是否放行奖励，放行才记录观看 + 启动冷却
      // （不在这里 reload，统一在 closed 里）
      case 'rewarded.rewarded':
        _onRewardedCompleted();
        break;
      // 激励视频关闭（无论是否看完）：重新加载备用 + 跳历史页
      case 'rewarded.closed':
        debugPrint('[AdService] rewarded.closed: reload + navigate to /history (返回时不再弹插屏)');
        _endRewardedFlow();
        loadRewardedAd();
        Get.toNamed('/history');
        break;

      // 开屏：不记录
      case 'splash.dismissed':
      case 'splash.failed':
        if (!_splashDone.isCompleted) _splashDone.complete();
        break;

      // 插屏关闭：前置 → 延迟300ms再弹激励
      case 'interstitial.dismissed':
        if (_interstitialIsPreRewarded) {
          _interstitialIsPreRewarded = false;
          _postInterstitialTimer?.cancel();
          _postInterstitialTimer = Timer(_randomDelay(), showRewardedAd);
        }
        break;

      // 插屏加载失败：前置 → 跳过直接弹激励
      case 'interstitial.failed':
        _onInterstitialUnavailable();
        break;
    }
  }

  /// 激励视频看完时调用一次风控，BLOCK/THROTTLE 则不发奖励，仍进入冷却避免立即重试。
  Future<void> _onRewardedCompleted() async {
    debugPrint('[AdService] rewarded.rewarded: checking risk gate before granting reward');
    final result = await RiskGateService.to.checkRewardCompletion();
    if (result.action.isBlocked) {
      debugPrint(
          '[AdService] reward denied by risk gate: ${result.action} ${result.reason}');
      _startCooldown();
      return;
    }
    debugPrint(
        '[AdService] reward allowed by risk gate: ${result.action} ${result.reason}, recording...');
    await _recordRewarded();
  }

  Future<void> _recordRewarded() async {
    await StorageService.saveAdRecord('rewarded');
    todayWatchCount.value = StorageService.todayAdRecords.length;
    _startCooldown();
  }

  /// 激励视频看完后的冷却：45~90 秒随机。
  void _startCooldown() => _runCooldown(minSeconds: 45, maxSeconds: 90);

  /// 注册并自动登录成功后触发一次的冷却：90~120 秒随机，避免刚注册即刷广告。
  void startPostRegistrationCooldown() =>
      _runCooldown(minSeconds: 90, maxSeconds: 120);

  void _runCooldown({required int minSeconds, required int maxSeconds}) {
    _cooldownTimer?.cancel();
    final span = maxSeconds - minSeconds + 1;
    final seconds = minSeconds + Random().nextInt(span);
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
