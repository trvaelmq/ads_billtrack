import Flutter
import UIKit
import UserNotifications
import AppTrackingTransparency

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var eventChannel: FlutterEventChannel?

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 本地通知代理（flutter_local_notifications 要求在 super 之前设置）
        UNUserNotificationCenter.current().delegate = self

        // 请求 ATT 权限（iOS 14+ 必须在 GDT 初始化前或初始化后立即请求）
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { _ in }
        }

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

    private func handleMethodCall(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult,
        controller: UIViewController
    ) {
        let args = call.arguments as? [String: Any]
        func posId(_ fallback: String) -> String { args?["posId"] as? String ?? fallback }

        switch call.method {
        case "showSplashAd":
            AdManager.shared.loadSplashAd(posId: posId(AdConfig.splashPosId), viewController: controller)
            result(nil)
        case "dismissSplashAd":
            AdManager.shared.dismissSplashAd()
            result(nil)
        case "loadRewardedAd":
            AdManager.shared.loadRewardedAd(posId: posId(AdConfig.rewardedPosId), viewController: controller)
            result(nil)
        case "showRewardedAd":
            AdManager.shared.showRewardedAd(viewController: controller)
            result(nil)
        case "showInterstitialAd":
            AdManager.shared.loadInterstitialAd(posId: posId(AdConfig.interstitialPosId), viewController: controller)
            result(nil)
        case "showFullScreenInterstitialAd":
            AdManager.shared.loadFullScreenInterstitialAd(posId: posId(AdConfig.interstitialPosId), viewController: controller)
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
