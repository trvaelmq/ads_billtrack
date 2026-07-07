import Flutter

class BannerAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let posId = params?["posId"] as? String ?? AdConfig.bannerPosId
        return BannerAdPlatformView(frame: frame, posId: posId, viewController: viewController ?? UIViewController())
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class BannerAdPlatformView: NSObject, FlutterPlatformView {
    private let container: BannerContainerView

    init(frame: CGRect, posId: String, viewController: UIViewController) {
        container = BannerContainerView(frame: frame, posId: posId, viewController: viewController)
        super.init()
    }

    func view() -> UIView { return container }
}

// 用自定义 UIView，在 layoutSubviews 时才创建 banner，保证宽度不为 0
class BannerContainerView: UIView {
    private let posId: String
    private weak var viewController: UIViewController?
    private var bannerManager: SFBannerManager?

    init(frame: CGRect, posId: String, viewController: UIViewController) {
        self.posId = posId
        self.viewController = viewController
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard bannerManager == nil, bounds.width > 0, bounds.height > 0,
              let vc = viewController else { return }

        let manager = SFBannerManager()
        manager.mediaId = posId
        manager.size = bounds.size
        manager.showAdController = vc
        manager.delegate = self
        bannerManager = manager
        manager.loadAdData()
        debugPrint("[Banner] 开始加载，size=\(bounds.width)x\(bounds.height)")
    }
}

extension BannerContainerView: SFBannerDelegate {
    func bannerAdDidLoad() {
        bannerManager?.showBannerAd(with: self)
        debugPrint("[Banner] 加载成功")
    }
    func bannerAdDidFailed(_ error: Error) {
        debugPrint("[Banner] 加载失败 \(error.localizedDescription)")
    }
    func bannerAdDidClose() {
        subviews.forEach { $0.removeFromSuperview() }
    }
}
