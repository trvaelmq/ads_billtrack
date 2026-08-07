import Flutter
import UIKit
import UserNotifications
import AppTrackingTransparency
import Security
import CoreTelephony

@main
@objc class AppDelegate: FlutterAppDelegate {

    private var eventChannel: FlutterEventChannel?
    private var hasRequestedTracking = false
    private var hasRequestedNotifications = false

    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        // 本地通知代理（flutter_local_notifications 要求在 super 之前设置）
        UNUserNotificationCenter.current().delegate = self

        // ATT 权限不在此处请求：didFinishLaunching 阶段 App 仍是 inactive 状态，
        // 系统会静默丢弃弹窗。改为在 applicationDidBecomeActive 中请求（见下方）。

        guard let controller = window?.rootViewController as? FlutterViewController else {
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }

        // 初始化芒果聚合 SDK（需在 window 指定 rootViewController 之后）
        SFAdSDKManager.registerAppId(AdConfig.appId)

        // PlatformView: Banner 广告注册
        let bannerFactory = BannerAdViewFactory(
            viewController: controller, messenger: controller.binaryMessenger)
        registrar(forPlugin: "BannerAdPlugin")?
            .register(bannerFactory, withId: "com.billtrack/banner_ad")

        // PlatformView: 原生模板广告注册
        let nativeExpressFactory = NativeExpressAdViewFactory(
            viewController: controller, messenger: controller.binaryMessenger)
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
    ///
    /// 注意与通知权限弹窗的竞态：任何系统权限弹窗出现时 App 会短暂 resign active，
    /// 此时发起的 ATT 请求会被系统静默丢弃且不弹窗。因此这里：
    /// 1. 请求前校验 applicationState == .active，非 active 则等下次 didBecomeActive 重试；
    /// 2. 回调返回仍是 .notDetermined（弹窗被丢弃）时重置标记，允许重试；
    /// 3. 通知权限统一在 ATT 得出结论后再请求（见 requestNotificationPermissionIfNeeded），
    ///    Dart 侧 NotificationService 不再于启动期主动申请，两个弹窗串行不打架。
    private func requestTrackingAuthorizationIfNeeded() {
        guard #available(iOS 14, *),
              ATTrackingManager.trackingAuthorizationStatus == .notDetermined else {
            // ATT 不可用或已有结论，直接进入通知授权
            requestNotificationPermissionIfNeeded()
            return
        }
        guard !hasRequestedTracking else { return }
        hasRequestedTracking = true
        // 短暂延迟，确保窗口/启动页过渡完成后再弹窗，提升呈现稳定性。
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
            guard let self else { return }
            guard UIApplication.shared.applicationState == .active else {
                self.hasRequestedTracking = false
                return
            }
            ATTrackingManager.requestTrackingAuthorization { status in
                DispatchQueue.main.async {
                    if status == .notDetermined {
                        self.hasRequestedTracking = false
                    } else {
                        self.requestNotificationPermissionIfNeeded()
                    }
                }
            }
        }
    }

    /// 通知权限请求，在 ATT 流程结束后串行触发。
    /// 系统对已授权/已拒绝的重复请求是 no-op，标记仅用于避免本次启动内重复调用。
    private func requestNotificationPermissionIfNeeded() {
        guard !hasRequestedNotifications else { return }
        hasRequestedNotifications = true
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { _, _ in }
    }

    private func handleMethodCall(
        _ call: FlutterMethodCall,
        result: @escaping FlutterResult,
        controller: UIViewController
    ) {
        let args = call.arguments as? [String: Any]
        func posId(_ fallback: String) -> String { args?["posId"] as? String ?? fallback }

        switch call.method {
        case "getDeviceId":
            result(DeviceIdentifier.persistentId())
        case "getDeviceSignals":
            result(currentDeviceSignals())
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
        case "showInterstitialAd", "showFullScreenInterstitialAd":
            AdManager.shared.showInterstitialAd(posId: posId(AdConfig.interstitialPosId), viewController: controller)
            result(nil)
        default:
            result(FlutterMethodNotImplemented)
        }
    }

    /// 风控网关 signals 字段用：机型标识/系统版本/是否插卡/运营商。
    /// 运营商名 iOS 16 起系统 API 基本恒返回 nil（Apple 出于隐私移除），属已知限制，尽力而为。
    private func currentDeviceSignals() -> [String: Any] {
        var systemInfo = utsname()
        uname(&systemInfo)
        let deviceModel = withUnsafePointer(to: &systemInfo.machine) {
            $0.withMemoryRebound(to: CChar.self, capacity: 1) { String(cString: $0) }
        }
        let telephonyInfo = CTTelephonyNetworkInfo()
        let carriers = telephonyInfo.serviceSubscriberCellularProviders?.values ?? [:].values
        // simPresent 不能用 serviceSubscriberCellularProviders 是否为空判断：只要设备有蜂窝模块，
        // 不管有没有插卡这个字典都非空（未插卡的 slot 里 CTCarrier 字段全是 nil，但条目本身还在），
        // 导致几乎所有 iPhone 都被误判为已插卡。改用 serviceCurrentRadioAccessTechnology——
        // 只有 SIM 真正注册上蜂窝网络才会有值，没插卡的 slot 永远不会出现在这个字典里。
        // 已知取舍：飞行模式/完全无信号时，插着卡也会被判为未插卡，属于尽力而为。
        let simPresent = !(telephonyInfo.serviceCurrentRadioAccessTechnology?.values.isEmpty ?? true)
        return [
            "deviceModel": deviceModel,
            "systemVersion": UIDevice.current.systemVersion,
            "simPresent": simPresent,
            "simCarrier": carriers.first?.carrierName ?? NSNull(),
            "idfv": UIDevice.current.identifierForVendor?.uuidString ?? NSNull(),
        ]
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

/// 设备唯一标识：首次生成 UUID 写入 Keychain，卸载重装后仍保留，
/// 用于服务端广告限频。不依赖 IDFA/ATT 授权。
enum DeviceIdentifier {
    private static let service = "com.jileduo.finance.deviceid"
    private static let account = "device_id"

    static func persistentId() -> String {
        if let existing = read() { return existing }
        let fresh = UUID().uuidString
        save(fresh)
        return fresh
    }

    private static func read() -> String? {
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecReturnData as String: true,
            kSecMatchLimit as String: kSecMatchLimitOne,
        ]
        var item: CFTypeRef?
        guard SecItemCopyMatching(query as CFDictionary, &item) == errSecSuccess,
              let data = item as? Data,
              let id = String(data: data, encoding: .utf8), !id.isEmpty
        else { return nil }
        return id
    }

    private static func save(_ id: String) {
        let attrs: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: account,
            kSecValueData as String: Data(id.utf8),
            kSecAttrAccessible as String: kSecAttrAccessibleAfterFirstUnlock,
        ]
        SecItemDelete(attrs as CFDictionary)
        SecItemAdd(attrs as CFDictionary, nil)
    }
}
