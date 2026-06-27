import Flutter

class BannerAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let posId = params?["posId"] as? String ?? AdConfig.bannerPosId
        let floor = params?["floor"] as? Int ?? 0
        return BannerAdPlatformView(frame: frame, posId: posId, floor: floor, viewController: viewController ?? UIViewController())
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class BannerAdPlatformView: NSObject, FlutterPlatformView {
    private let container: BannerContainerView

    init(frame: CGRect, posId: String, floor: Int, viewController: UIViewController) {
        container = BannerContainerView(frame: frame, posId: posId, floor: floor, viewController: viewController)
        super.init()
    }

    func view() -> UIView { return container }
}

// 用自定义 UIView，在 layoutSubviews 时才创建 banner，保证宽度不为 0
class BannerContainerView: UIView {
    private let posId: String
    private let floor: Int
    private weak var viewController: UIViewController?
    private var bannerView: GDTUnifiedBannerView?

    init(frame: CGRect, posId: String, floor: Int, viewController: UIViewController) {
        self.posId = posId
        self.floor = floor
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
        // 每次自动刷新都会回调，重新读价决定显隐
        switch gdtEvaluateBid(eCPM: unifiedBannerView.eCPM(), floor: floor, ad: unifiedBannerView) {
        case .lost:
            unifiedBannerView.isHidden = true
            debugPrint("[Banner] 竞败 ecpm=\(unifiedBannerView.eCPM()) floor=\(floor)，隐藏")
        case .won, .skipped:
            unifiedBannerView.isHidden = false
            debugPrint("[Banner] 加载成功 ecpm=\(unifiedBannerView.eCPM()) floor=\(floor)")
        }
    }
    func unifiedBannerViewFailedToLoad(_ unifiedBannerView: GDTUnifiedBannerView, withError error: NSError) {
        debugPrint("[Banner] 加载失败: \(error.localizedDescription)")
    }
}
