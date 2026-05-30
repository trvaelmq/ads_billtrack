import Flutter

class NativeExpressAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let posId  = params?["posId"]  as? String  ?? AdConfig.interstitialPosId
        let height = params?["height"] as? CGFloat ?? frame.height
        return NativeExpressAdPlatformView(
            frame: frame, posId: posId, adHeight: height,
            viewController: viewController ?? UIViewController()
        )
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeExpressAdPlatformView: NSObject, FlutterPlatformView {
    private let container: NativeExpressContainerView

    init(frame: CGRect, posId: String, adHeight: CGFloat, viewController: UIViewController) {
        container = NativeExpressContainerView(frame: frame, posId: posId, adHeight: adHeight, viewController: viewController)
        super.init()
    }

    func view() -> UIView { container }
}

class NativeExpressContainerView: UIView {
    private let posId: String
    private let adHeight: CGFloat
    private weak var viewController: UIViewController?
    private var nativeAd: GDTNativeExpressAd?
    private var adView: GDTNativeExpressAdView?
    private var loaded = false

    init(frame: CGRect, posId: String, adHeight: CGFloat, viewController: UIViewController) {
        self.posId = posId
        self.adHeight = adHeight
        self.viewController = viewController
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard !loaded, bounds.width > 0 else { return }
        loaded = true
        let adSize = CGSize(width: bounds.width, height: adHeight)
        guard let ad = GDTNativeExpressAd(placementId: posId, adSize: adSize) else { return }
        ad.delegate = self
        ad.load(1)
        nativeAd = ad
        debugPrint("[NativeExpress] 开始加载 posId=\(posId) size=\(adSize)")
    }
}

extension NativeExpressContainerView: GDTNativeExpressAdDelegete {
    func nativeExpressAdSuccess(toLoad nativeExpressAd: GDTNativeExpressAd,
                                views: [GDTNativeExpressAdView]) {
        guard let adView = views.first, let vc = viewController else { return }
        self.adView = adView
        adView.controller = vc  // 属性名为 controller
        adView.render()
        debugPrint("[NativeExpress] 加载成功，开始 render")
    }

    func nativeExpressAdViewRenderSuccess(_ nativeExpressAdView: GDTNativeExpressAdView) {
        nativeExpressAdView.frame = bounds
        addSubview(nativeExpressAdView)
        debugPrint("[NativeExpress] render 成功")
    }

    func nativeExpressAdViewRenderFail(_ nativeExpressAdView: GDTNativeExpressAdView) {
        debugPrint("[NativeExpress] render 失败")
    }

    func nativeExpressAdFailToLoad(_ nativeExpressAd: GDTNativeExpressAd, error: NSError) {
        debugPrint("[NativeExpress] 加载失败: \(error.localizedDescription)")
    }
}
