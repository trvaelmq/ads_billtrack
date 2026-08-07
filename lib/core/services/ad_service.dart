import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../constants/ad_config.dart';
import '../utils/app_dialogs.dart';
import '../../router/app_pages.dart';
import 'auth_service.dart';
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
    // App 重新打开：本地冷却计时在杀进程后会丢失，调一次 /risk/check 按后端权威状态恢复冷却。
    _syncCooldownFromCheck();
  }

  /// 拉一次 /risk/check 同步冷却状态，不触发广告流程、不弹提示（用于 App 启动时静默对齐）。
  Future<void> _syncCooldownFromCheck() async {
    if (!Get.isRegistered<RiskGateService>()) return;
    final result = await RiskGateService.to.checkAdAvailability();
    if (result.action == RiskAction.stop && result.resetInSeconds != null) {
      _runCooldown(minSeconds: result.resetInSeconds!, maxSeconds: result.resetInSeconds!);
    }
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

  /// 点击"看激励视频"时调用：先问一次风控 /risk/check 是否可以看，
  /// 放行才延迟3秒弹插屏，插屏关闭后再延迟3秒弹激励；STOP 用返回的 resetInSeconds 冷却。
  Future<void> startRewardedAdFlow() async {
    if (_rewardedFlowInProgress) return; // 流程进行中，忽略重复点击
    _rewardedFlowInProgress = true;
    final result = await RiskGateService.to.checkAdAvailability();
    switch (result.action) {
      case RiskAction.stop:
        debugPrint('[AdService] ad denied by risk check: ${result.action} ${result.reason}');
        if (result.message != null) {
          AppDialogs.showRiskStop(result.message!);
        }
        _runCooldown(
          minSeconds: result.resetInSeconds ?? 45,
          maxSeconds: result.resetInSeconds ?? 90,
        );
        _rewardedFlowInProgress = false;
        return;
      case RiskAction.block:
        debugPrint('[AdService] ad denied by risk check, forcing logout: ${result.reason}');
        _rewardedFlowInProgress = false;
        await _forceLogout();
        return;
      case RiskAction.throttle:
        debugPrint('[AdService] ad denied by risk check: ${result.action} ${result.reason}');
        _startCooldown();
        _rewardedFlowInProgress = false;
        return;
      case RiskAction.pass:
      case RiskAction.review:
      case RiskAction.shadow:
        _interstitialIsPreRewarded = true;
        _preRewardedTimer = Timer(_randomDelay(), showInterstitialAd);
    }
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
      // 激励视频关闭（无论是否看完）：重新加载备用，留在当前页
      case 'rewarded.closed':
        debugPrint('[AdService] rewarded.closed: reload (返回时不再弹插屏，不跳转)');
        _endRewardedFlow();
        loadRewardedAd();
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

  /// 激励视频看完即记一条观看记录（不依赖风控结果，看了就算看了）；
  /// 之后再调一次风控决定冷却时长：BLOCK 由后端删 token 下线账号，App 强制登出；
  /// THROTTLE/STOP（达到上限）进冷却，不影响登录态、不影响已记的观看记录。
  Future<void> _onRewardedCompleted() async {
    debugPrint('[AdService] rewarded.rewarded: recording watch, then checking risk gate');
    await _recordWatch();
    final result = await RiskGateService.to.checkRewardCompletion();
    switch (result.action) {
      case RiskAction.block:
        debugPrint(
            '[AdService] reward blocked by risk gate, forcing logout: ${result.reason}');
        await _forceLogout();
        return;
      case RiskAction.throttle:
        debugPrint(
            '[AdService] reward denied by risk gate: ${result.action} ${result.reason}');
        _startCooldown();
        return;
      case RiskAction.stop:
        debugPrint(
            '[AdService] reward denied by risk gate: ${result.action} ${result.reason}');
        if (result.message != null) {
          AppDialogs.showRiskStop(result.message!);
        }
        _runCooldown(
          minSeconds: result.resetInSeconds ?? 45,
          maxSeconds: result.resetInSeconds ?? 90,
        );
        return;
      case RiskAction.pass:
      case RiskAction.review:
      case RiskAction.shadow:
        _startCooldown();
    }
  }

  /// BLOCK 时后端已删除 token：清本地登录态，不依赖 401 拦截器的静默清理。
  /// App 本身支持游客态浏览，不强制跳登录页，只保留 main 作为底层路由，退回未登录态即可；
  /// 后续再触发需要登录的操作时，走 ensureLoggedIn 闸门正常弹登录。
  Future<void> _forceLogout() async {
    if (Get.isRegistered<AuthService>()) {
      await AuthService.to.logout();
    }
    await Get.offAllNamed(Routes.main);
  }

  Future<void> _recordWatch() async {
    await StorageService.saveAdRecord('rewarded');
    todayWatchCount.value = StorageService.todayAdRecords.length;
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
