import Flutter

class BannerAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let posId = (args as? [String: Any])?["posId"] as? String ?? AdConfig.bannerPosId
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
    private var bannerView: GDTUnifiedBannerView?

    init(frame: CGRect, posId: String, viewController: UIViewController) {
        self.posId = posId
        self.viewController = viewController
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard bannerView == nil, bounds.width > 0, bounds.height > 0,
              let vc = viewController else { return }

        let banner = GDTUnifiedBannerView(
            frame: CGRect(x: 0, y: 0, width: bounds.width, height: bounds.height),
            placementId: posId,
            viewController: vc
        )
        banner.autoSwitchInterval = 30
        banner.delegate = self
        banner.loadAdAndShow()
        addSubview(banner)
        bannerView = banner
        debugPrint("[Banner] 开始加载，size=\(bounds.width)x\(bounds.height)")
    }
}

extension BannerContainerView: GDTUnifiedBannerViewDelegate {
    func unifiedBannerViewDidLoad(_ unifiedBannerView: GDTUnifiedBannerView) {
        debugPrint("[Banner] 加载成功")
    }
    func unifiedBannerViewFailedToLoad(_ unifiedBannerView: GDTUnifiedBannerView, withError error: NSError) {
        debugPrint("[Banner] 加载失败: \(error.localizedDescription)")
    }
}
