import Flutter

class NativeExpressAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?
    private let messenger: FlutterBinaryMessenger

    init(viewController: UIViewController, messenger: FlutterBinaryMessenger) {
        self.viewController = viewController
        self.messenger = messenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let posId  = params?["posId"]  as? String  ?? AdConfig.detailBannerPosId
        let height = params?["height"] as? CGFloat ?? frame.height
        let channel = FlutterMethodChannel(
            name: "com.billtrack/ad_view_\(viewId)", binaryMessenger: messenger)
        return NativeExpressAdPlatformView(
            frame: frame, posId: posId, adHeight: height,
            viewController: viewController ?? UIViewController(), channel: channel
        )
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class NativeExpressAdPlatformView: NSObject, FlutterPlatformView {
    private let container: NativeExpressContainerView

    init(frame: CGRect, posId: String, adHeight: CGFloat, viewController: UIViewController, channel: FlutterMethodChannel) {
        container = NativeExpressContainerView(
            frame: frame, posId: posId, adHeight: adHeight,
            viewController: viewController, channel: channel)
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
    private let channel: FlutterMethodChannel
    private var nativeManager: SFNativeManager?

    init(frame: CGRect, posId: String, adHeight: CGFloat, viewController: UIViewController, channel: FlutterMethodChannel) {
        self.posId = posId
        self.adHeight = adHeight
        self.viewController = viewController
        self.channel = channel
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
    func nativeAdDidClicked() {
        channel.invokeMethod("clicked", arguments: nil)
    }
    func nativeAdDidRenderSuccess(withADView nativeAdView: UIView) {
        // 测量渲染视图真实高度，按内容尺寸布局并回传 Flutter 自适应
        var h = nativeAdView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        if h <= 1 { h = nativeAdView.sizeThatFits(CGSize(width: bounds.width, height: 0)).height }
        if h <= 1 { h = adHeight }
        nativeAdView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: h)
        addSubview(nativeAdView)
        debugPrint("[NativeExpress] render 成功 height=\(h)")
        channel.invokeMethod("resize", arguments: Double(h))
    }
    func nativeAdDidFailed(_ error: Error) {
        debugPrint("[NativeExpress] 加载失败 \(error.localizedDescription)")
    }
    func nativeAdDidClose(withADView nativeAdView: UIView) {
        nativeAdView.removeFromSuperview()
        channel.invokeMethod("resize", arguments: Double(0)) // 关闭后 Flutter 收起占位
    }
}
