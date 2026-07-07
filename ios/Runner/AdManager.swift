import Flutter

class AdManager: NSObject {
    static let shared = AdManager()
    var eventSink: FlutterEventSink?

    private var splashManager: SFSplashManager?
    private var rewardedManager: SFRewardVideoManager?
    private var interstitialManager: SFInterstitialManager?
    private var splashOverlayWindow: UIWindow?   // 独立高层级窗口，覆盖 Flutter 内容
    private var rewardedReady = false

    // ── Splash ────────────────────────────────────────────────────
    func loadSplashAd(posId: String, viewController: UIViewController) {
        // 创建独立 UIWindow，windowLevel 高于主窗口，确保盖住 Flutter 页面
        let overlayWindow: UIWindow
        if #available(iOS 13, *) {
            let scene = viewController.view.window?.windowScene
            overlayWindow = scene != nil ? UIWindow(windowScene: scene!) : UIWindow(frame: UIScreen.main.bounds)
        } else {
            overlayWindow = UIWindow(frame: UIScreen.main.bounds)
        }
        overlayWindow.windowLevel = .statusBar + 1
        // 与启动页颜色一致（#3F51B5），避免广告关闭后出现黑屏
        let themeColor = UIColor(red: 0.247, green: 0.318, blue: 0.710, alpha: 1)
        overlayWindow.backgroundColor = themeColor
        let rootVC = UIViewController()
        rootVC.view.backgroundColor = themeColor
        overlayWindow.rootViewController = rootVC
        overlayWindow.makeKeyAndVisible()
        splashOverlayWindow = overlayWindow

        let manager = SFSplashManager()
        manager.mediaId = posId
        manager.delegate = self
        manager.timeout = 5
        manager.showAdController = rootVC
        splashManager = manager
        manager.loadAdData()
    }

    func dismissSplashAd() {
        removeSplashOverlay()
        splashManager = nil
    }

    private func removeSplashOverlay() {
        splashOverlayWindow?.isHidden = true
        splashOverlayWindow = nil
    }

    // ── Rewarded Video ────────────────────────────────────────────
    func loadRewardedAd(posId: String, viewController: UIViewController) {
        rewardedReady = false
        let manager = SFRewardVideoManager()
        manager.mediaId = posId
        manager.delegate = self
        rewardedManager = manager
        manager.loadAdData(withExtra: nil)
        sendEvent("rewarded", event: "loading")
    }

    func showRewardedAd(viewController: UIViewController) {
        guard rewardedReady, let manager = rewardedManager else {
            sendEvent("rewarded", event: "not_ready"); return
        }
        manager.showRewardVideoAd(with: viewController)
    }

    // ── Interstitial ──────────────────────────────────────────────
    // 芒果聚合无「弹框/全屏」之分，两个方法入口共用此实现
    func showInterstitialAd(posId: String, viewController: UIViewController) {
        let manager = SFInterstitialManager()
        manager.mediaId = posId
        manager.delegate = self
        manager.showAdController = viewController
        interstitialManager = manager
        manager.loadAdData()
        sendEvent("interstitial", event: "loading")
    }

    // ── Helper ────────────────────────────────────────────────────
    func sendEvent(_ type: String, event: String, msg: String = "") {
        var data: [String: Any] = ["type": type, "event": event]
        if !msg.isEmpty { data["msg"] = msg }
        DispatchQueue.main.async { self.eventSink?(data) }
    }
}

// ── Delegates ─────────────────────────────────────────────────────
extension AdManager: SFSplashDelegate {
    func splashAdDidLoad() {
        guard let window = splashOverlayWindow else {
            sendEvent("splash", event: "failed", msg: "overlay window missing")
            return
        }
        splashManager?.showSplashAd(with: window)
    }
    func splashAdDidVisible() {
        sendEvent("splash", event: "shown")
    }
    func splashAdDidFailed(_ error: Error) {
        // 先通知 Flutter 跳转，Flutter 跳转后再调 dismissSplashAd 移除 overlay，避免开屏页闪现
        sendEvent("splash", event: "failed", msg: error.localizedDescription)
        splashManager = nil
    }
    func splashAdDidClicked(withUrlStr urlStr: String?) {
        sendEvent("splash", event: "clicked")
    }
    func splashAdDidShowFinish() {
        sendEvent("splash", event: "dismissed")
        splashManager = nil
        // overlay 由 Flutter 调用 dismissSplashAd 移除，确保跳转后再隐藏
    }
}

extension AdManager: SFRewardVideoDelegate {
    func rewardedVideoDidLoad() {
        rewardedReady = true
        sendEvent("rewarded", event: "loaded")
    }
    func rewardedVideoDidFailWithError(_ error: Error) {
        rewardedReady = false
        sendEvent("rewarded", event: "failed", msg: error.localizedDescription)
    }
    func rewardedVideoDidVisible() {
        sendEvent("rewarded", event: "shown")
    }
    func rewardedVideoDidClick() {
        sendEvent("rewarded", event: "clicked")
    }
    func rewardedVideoDidRewardEffective(withExtra extra: [AnyHashable: Any]) {
        sendEvent("rewarded", event: "rewarded")
    }
    func rewardedVideoDidClose() {
        rewardedReady = false
        sendEvent("rewarded", event: "closed")
    }
}

extension AdManager: SFInterstitialDelegate {
    func interstitialAdDidLoad() {
        sendEvent("interstitial", event: "loaded")
        DispatchQueue.main.async { self.interstitialManager?.showInterstitialAd() }
    }
    func interstitialAdDidFailed(_ error: Error) {
        sendEvent("interstitial", event: "failed", msg: error.localizedDescription)
    }
    func interstitialAdDidVisible() {
        sendEvent("interstitial", event: "shown")
    }
    func interstitialAdDidClick() {
        sendEvent("interstitial", event: "clicked")
    }
    func interstitialAdDidAutoClose(_ autoClose: Bool) {
        sendEvent("interstitial", event: "dismissed")
    }
}
