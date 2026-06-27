import Flutter

class AdManager: NSObject {
    static let shared = AdManager()
    var eventSink: FlutterEventSink?

    private var splashAd: GDTSplashAd?
    private var rewardedAd: GDTRewardVideoAd?
    private var interstitialAd: GDTUnifiedInterstitialAd?
    private var splashOverlayWindow: UIWindow?   // 独立高层级窗口，覆盖 Flutter 内容
    private weak var interstitialVC: UIViewController?
    private var interstitialIsFullScreen = false
    private var splashFloor = 0
    private var rewardedFloor = 0
    private var interstitialFloor = 0

    // ── Splash ────────────────────────────────────────────────────
    func loadSplashAd(posId: String, floor: Int, viewController: UIViewController) {
        splashFloor = floor
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

        splashAd = GDTSplashAd(placementId: posId)
        splashAd?.delegate = self
        splashAd?.fetchDelay = 3
        splashAd?.load()
    }

    func dismissSplashAd() {
        removeSplashOverlay()
        splashAd = nil
    }

    private func removeSplashOverlay() {
        splashOverlayWindow?.isHidden = true
        splashOverlayWindow = nil
    }

    // ── Rewarded Video ────────────────────────────────────────────
    func loadRewardedAd(posId: String, floor: Int, viewController: UIViewController) {
        rewardedFloor = floor
        rewardedAd = GDTRewardVideoAd(placementId: posId)
        rewardedAd?.delegate = self
        rewardedAd?.load()
        sendEvent("rewarded", event: "loading")
    }

    func showRewardedAd(viewController: UIViewController) {
        guard let ad = rewardedAd, ad.isAdValid else {
            sendEvent("rewarded", event: "not_ready"); return
        }
        let e = ad.eCPM()
        switch gdtEvaluateBid(eCPM: e, floor: rewardedFloor, ad: ad) {
        case .won:
            sendEvent("rewarded", event: "bid_won", ecpm: e, floor: rewardedFloor)
            ad.show(fromRootViewController: viewController)
        case .skipped:
            ad.show(fromRootViewController: viewController)
        case .lost:
            sendEvent("rewarded", event: "bid_lost", ecpm: e, floor: rewardedFloor)
            sendEvent("rewarded", event: "not_ready") // 复用 not_ready 让 Flutter 结束流程并 reload
            rewardedAd = nil
        }
    }

    // ── Interstitial（弹框）────────────────────────────────────────
    func loadInterstitialAd(posId: String, floor: Int, viewController: UIViewController) {
        interstitialIsFullScreen = false
        interstitialFloor = floor
        interstitialVC = viewController
        interstitialAd = GDTUnifiedInterstitialAd(placementId: posId)
        interstitialAd?.delegate = self
        interstitialAd?.load()
        sendEvent("interstitial", event: "loading")
    }

    // ── Interstitial（全屏）────────────────────────────────────────
    func loadFullScreenInterstitialAd(posId: String, floor: Int, viewController: UIViewController) {
        interstitialIsFullScreen = true
        interstitialFloor = floor
        interstitialVC = viewController
        interstitialAd = GDTUnifiedInterstitialAd(placementId: posId)
        interstitialAd?.delegate = self
        interstitialAd?.loadFullScreenAd()
        sendEvent("interstitial", event: "loading")
    }

    // ── Helper ────────────────────────────────────────────────────
    func sendEvent(_ type: String, event: String, msg: String = "") {
        var data: [String: Any] = ["type": type, "event": event]
        if !msg.isEmpty { data["msg"] = msg }
        DispatchQueue.main.async { self.eventSink?(data) }
    }

    func sendEvent(_ type: String, event: String, ecpm: Int, floor: Int) {
        let data: [String: Any] = ["type": type, "event": event, "ecpm": ecpm, "floor": floor]
        DispatchQueue.main.async { self.eventSink?(data) }
    }
}

// ── Delegates ─────────────────────────────────────────────────────
extension AdManager: GDTSplashAdDelegate {
    func splashAdDidLoad(_ splashAd: GDTSplashAd) {
        guard let window = splashOverlayWindow else {
            sendEvent("splash", event: "failed", msg: "overlay window missing")
            return
        }
        let e = splashAd.eCPM()
        switch gdtEvaluateBid(eCPM: e, floor: splashFloor, ad: splashAd) {
        case .won:
            sendEvent("splash", event: "bid_won", ecpm: e, floor: splashFloor)
            splashAd.show(in: window, withBottomView: nil, skip: nil)
        case .skipped:
            splashAd.show(in: window, withBottomView: nil, skip: nil)
        case .lost:
            sendEvent("splash", event: "bid_lost", ecpm: e, floor: splashFloor)
            // 复用 failed：Flutter 收到后完成 splashDone → 进首页 → 调 dismissSplashAd 移除 overlay
            sendEvent("splash", event: "failed", msg: "bid_lost")
            self.splashAd = nil
        }
    }
    func splashAdSuccessPresentScreen(_ splashAd: GDTSplashAd) {
        sendEvent("splash", event: "shown")
    }
    func splashAdFail(toPresent splashAd: GDTSplashAd, withError error: NSError) {
        // 先通知 Flutter 跳转，Flutter 跳转后再移除 overlay，避免开屏页闪现
        sendEvent("splash", event: "failed", msg: error.localizedDescription)
        self.splashAd = nil
    }
    func splashAdClosed(_ splashAd: GDTSplashAd) {
        sendEvent("splash", event: "dismissed")
        self.splashAd = nil
        // overlay 由 Flutter 调用 dismissSplashAd 移除，确保跳转后再隐藏
    }
}

extension AdManager: GDTRewardedVideoAdDelegate {
    func gdt_rewardVideoAdDidLoad(_ rewardedVideoAd: GDTRewardVideoAd) {
        sendEvent("rewarded", event: "loaded")
    }
    func gdt_rewardVideoAdVideoDidLoad(_ rewardedVideoAd: GDTRewardVideoAd) {
        sendEvent("rewarded", event: "video_loaded")
    }
    func gdt_rewardVideoAdWillVisible(_ rewardedVideoAd: GDTRewardVideoAd) {
        sendEvent("rewarded", event: "shown")
    }
    func gdt_rewardVideoAd(_ rewardedVideoAd: GDTRewardVideoAd, didFailWithError error: NSError) {
        sendEvent("rewarded", event: "failed", msg: error.localizedDescription)
    }
    func gdt_rewardVideoAdDidRewardEffective(_ rewardedVideoAd: GDTRewardVideoAd, info: [AnyHashable: Any]?) {
        sendEvent("rewarded", event: "rewarded")
    }
    func gdt_rewardVideoAdDidClose(_ rewardedVideoAd: GDTRewardVideoAd) {
        sendEvent("rewarded", event: "closed")
    }
}

extension AdManager: GDTUnifiedInterstitialAdDelegate {
    func unifiedInterstitialSuccess(toLoad unifiedInterstitial: GDTUnifiedInterstitialAd) {
        sendEvent("interstitial", event: "loaded")
        guard let vc = interstitialVC else { return }
        let e = unifiedInterstitial.eCPM()
        let result = gdtEvaluateBid(eCPM: e, floor: interstitialFloor, ad: unifiedInterstitial)
        switch result {
        case .lost:
            sendEvent("interstitial", event: "bid_lost", ecpm: e, floor: interstitialFloor)
            sendEvent("interstitial", event: "failed", msg: "bid_lost") // 复用 failed 让流程跳过
            self.interstitialAd = nil
        case .won, .skipped:
            if result == .won {
                sendEvent("interstitial", event: "bid_won", ecpm: e, floor: interstitialFloor)
            }
            DispatchQueue.main.async {
                if self.interstitialIsFullScreen {
                    unifiedInterstitial.presentFullScreenAd(fromRootViewController: vc)
                } else {
                    unifiedInterstitial.present(fromRootViewController: vc)
                }
            }
        }
    }
    func unifiedInterstitialDidPresentScreen(_ unifiedInterstitial: GDTUnifiedInterstitialAd) {
        sendEvent("interstitial", event: "shown")
    }
    func unifiedInterstitialDidDismissScreen(_ unifiedInterstitial: GDTUnifiedInterstitialAd) {
        sendEvent("interstitial", event: "dismissed")
    }
    func unifiedInterstitialFail(toLoad unifiedInterstitial: GDTUnifiedInterstitialAd, error: NSError) {
        sendEvent("interstitial", event: "failed", msg: error.localizedDescription)
    }
}
