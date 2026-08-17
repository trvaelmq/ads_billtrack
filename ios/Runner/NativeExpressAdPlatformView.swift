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
    private var lastHeight: CGFloat?
    private var heightObservation: NSKeyValueObservation?

    init(frame: CGRect, posId: String, adHeight: CGFloat, viewController: UIViewController, channel: FlutterMethodChannel) {
        self.posId = posId
        self.adHeight = adHeight
        self.viewController = viewController
        self.channel = channel
        super.init(frame: frame)
        // 兜底：若渲染完成推送 resize 时 Dart 端 handler 还未注册好导致消息丢失，
        // Dart 会在注册完成后主动查询一次当前高度；reload 供 Flutter 侧在上次加载
        // 失败、Tab 切回可见时主动触发一次重试（常驻 Tab 页面不会自然重新创建 view）。
        channel.setMethodCallHandler { [weak self] call, result in
            switch call.method {
            case "queryHeight":
                result(self?.lastHeight.map { Double($0) } ?? -1)
            case "reload":
                self?.loadAd()
                result(nil)
            default:
                result(FlutterMethodNotImplemented)
            }
        }
    }

    required init?(coder: NSCoder) { fatalError() }

    deinit { heightObservation?.invalidate() }

    override func layoutSubviews() {
        super.layoutSubviews()
        guard nativeManager == nil, bounds.width > 0 else { return }
        loadAd()
    }

    private func loadAd() {
        guard let vc = viewController else { return }
        heightObservation?.invalidate()
        heightObservation = nil
        subviews.forEach { $0.removeFromSuperview() }

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
        // 真实高度渲染时 SDK 已经算好放在 bounds/frame 里了（非 Auto Layout 视图，
        // systemLayoutSizeFitting 测不出东西，实测恒为 0，故不用它），直接读即可。
        var h = nativeAdView.bounds.height
        if h <= 1 { h = nativeAdView.frame.height }
        if h <= 1 { h = adHeight }
        nativeAdView.frame = CGRect(x: 0, y: 0, width: bounds.width, height: h)
        addSubview(nativeAdView)
        debugPrint("[NativeExpress] render 成功 height=\(h)")
        updateHeight(h)
        // 图片等素材可能异步加载完成后才把内容撑高，持续监听渲染视图尺寸变化，
        // 每次变化都重新同步高度给 Flutter，而不是只在渲染成功那一刻测一次。
        heightObservation = nativeAdView.layer.observe(\.bounds, options: [.new]) { [weak self] layer, _ in
            self?.updateHeight(layer.bounds.height)
        }
    }
    func nativeAdDidFailed(_ error: Error) {
        debugPrint("[NativeExpress] 加载失败 \(error.localizedDescription)")
        channel.invokeMethod("loadFailed", arguments: error.localizedDescription)
    }
    func nativeAdDidClose(withADView nativeAdView: UIView) {
        heightObservation?.invalidate()
        heightObservation = nil
        nativeAdView.removeFromSuperview()
        updateHeight(0)
    }

    private func updateHeight(_ h: CGFloat) {
        guard h != lastHeight else { return }
        lastHeight = h
        channel.invokeMethod("resize", arguments: Double(h))
    }
}
