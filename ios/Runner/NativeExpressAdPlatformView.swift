import Flutter

class NativeExpressAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?

    init(viewController: UIViewController) {
        self.viewController = viewController
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let posId  = params?["posId"]  as? String  ?? AdConfig.detailBannerPosId
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

// 芒果原生混出：模板样式由 SDK 渲染完成后经 nativeAdDidRenderSuccessWithADView 回调
// （芒果后台需将该广告位配置为模板样式）
class NativeExpressContainerView: UIView {
    private let posId: String
    private let adHeight: CGFloat
    private weak var viewController: UIViewController?
    private var nativeManager: SFNativeManager?

    init(frame: CGRect, posId: String, adHeight: CGFloat, viewController: UIViewController) {
        self.posId = posId
        self.adHeight = adHeight
        self.viewController = viewController
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard nativeManager == nil, bounds.width > 0, let vc = viewController else { return }

        let manager = SFNativeManager()
        manager.mediaId = posId
        manager.adCount = 1
        manager.size = CGSize(width: bounds.width, height: adHeight)
        manager.showAdController = vc
        manager.delegate = self
        nativeManager = manager
        manager.loadAdData()
        debugPrint("[NativeExpress] 开始加载 posId=\(posId)")
    }
}

extension NativeExpressContainerView: SFNativeDelegate {
    func nativeAdDidRenderSuccess(withADView nativeAdView: UIView) {
        nativeAdView.frame = bounds
        addSubview(nativeAdView)
        debugPrint("[NativeExpress] render 成功")
    }
    func nativeAdDidFailed(_ error: Error) {
        debugPrint("[NativeExpress] 加载失败 \(error.localizedDescription)")
    }
    func nativeAdDidClose(withADView nativeAdView: UIView) {
        nativeAdView.removeFromSuperview()
    }
}
