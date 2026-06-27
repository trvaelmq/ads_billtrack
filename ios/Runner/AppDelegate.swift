import Flutter
import UIKit
import UserNotifications
import AppTrackingTransparency

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var eventChannel: FlutterEventChannel?
    private var hasRequestedTracking = false

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 本地通知代理（flutter_local_notifications 要求在 super 之前设置）
        UNUserNotificationCenter.current().delegate = self

        // ATT 权限不在此处请求：didFinishLaunching 阶段 App 仍是 inactive 状态，
        // 系统会静默丢弃弹窗。改为在 applicationDidBecomeActive 中请求（见下方）。

        // 初始化 GDT SDK
        GDTSDKConfig.initWithAppId(AdConfig.appId)
        GDTSDKConfig.start { _, _ in }

        guard let controller = window?.rootViewController as? FlutterViewController else {
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }

        // PlatformView: Banner 广告注册
        let bannerFactory = BannerAdViewFactory(viewController: controller)
        registrar(forPlugin: "BannerAdPlugin")?
            .register(bannerFactory, withId: "com.billtrack/banner_ad")

        // PlatformView: 原生模板广告注册
        let nativeExpressFactory = NativeExpressAdViewFactory(viewController: controller)
        registrar(forPlugin: "NativeExpressAdPlugin")?
            .register(nativeExpressFactory, withId: "com.billtrack/native_express_ad")

        // MethodChannel
        let methodChannel = FlutterMethodChannel(
            name: AdChannels.method,
            binaryMessenger: controller.binaryMessenger
        )
        methodChannel.setMethodCallHandler { [weak self] call, result in
            self?.handleMethodCall(call, result: result, controller: controller)
        }

        // EventChannel
        eventChannel = FlutterEventChannel(
            name: AdChannels.event,
            binaryMessenger: controller.binaryMessenger
        )
        eventChannel?.setStreamHandler(self)

        GeneratedPluginRegistrant.register(with: self)
        return super.application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
        requestTrackingAuthorizationIfNeeded()
    }

    /// ATT 授权请求。系统只在 App 处于 active 前台状态时才会呈现弹窗，
    /// 因此必须在 applicationDidBecomeActive 中触发，而非 didFinishLaunching。
    private func requestTrackingAuthorizationIfNeeded() {
        guard #available(iOS 14, *) else { return }
        guard !hasRequestedTracking else { return }
        guard ATTrackingManager.trackingAuthorizationStatus == .notDetermined else { return }
        hasRequestedTracking = true
        // 短暂延迟，确保窗口/启动页过渡完成后再弹窗，提升呈现稳定性。
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            ATTrackingManager.requestTrackingAuthorization { _ in }
        }
    }

    private func handleMethodCall(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult,
        controller: UIViewController
    ) {
        let args = call.arguments as? [String: Any]
        func posId(_ fallback: String) -> String { args?["posId"] as? String ?? fallback }
        func floorArg() -> Int { args?["floor"] as? Int ?? 0 }

        switch call.method {
        case "showSplashAd":
            AdManager.shared.loadSplashAd(posId: posId(AdConfig.splashPosId), floor: floorArg(), viewController: controller)
            result(nil)
        case "dismissSplashAd":
            AdManager.shared.dismissSplashAd()
            result(nil)
        case "loadRewardedAd":
            AdManager.shared.loadRewardedAd(posId: posId(AdConfig.rewardedPosId), floor: floorArg(), viewController: controller)
            result(nil)
        case "showRewardedAd":
            AdManager.shared.showRewardedAd(viewController: controller)
            result(nil)
        case "showInterstitialAd":
            AdManager.shared.loadInterstitialAd(posId: posId(AdConfig.interstitialPosId), floor: floorArg(), viewController: controller)
            result(nil)
        case "showFullScreenInterstitialAd":
            AdManager.shared.loadFullScreenInterstitialAd(posId: posId(AdConfig.interstitialPosId), floor: floorArg(), viewController: controller)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }
}

extension AppDelegate: FlutterStreamHandler {
    func onListen(withArguments arguments: Any?, eventSink events: @escaping FlutterEventSink) -> FlutterError? {
        AdManager.shared.eventSink = events
        return nil
    }
    func onCancel(withArguments arguments: Any?) -> FlutterError? {
        AdManager.shared.eventSink = nil
        return nil
    }
}
