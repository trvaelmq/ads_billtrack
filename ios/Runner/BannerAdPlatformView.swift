import Flutter

class BannerAdViewFactory: NSObject, FlutterPlatformViewFactory {
    private weak var viewController: UIViewController?
    private let messenger: FlutterBinaryMessenger

    init(viewController: UIViewController, messenger: FlutterBinaryMessenger) {
        self.viewController = viewController
        self.messenger = messenger
    }

    func create(withFrame frame: CGRect, viewIdentifier viewId: Int64, arguments args: Any?) -> FlutterPlatformView {
        let params = args as? [String: Any]
        let posId = params?["posId"] as? String ?? AdConfig.bannerPosId
        let channel = FlutterMethodChannel(
            name: "com.billtrack/ad_view_\(viewId)", binaryMessenger: messenger)
        return BannerAdPlatformView(
            frame: frame, posId: posId,
            viewController: viewController ?? UIViewController(), channel: channel)
    }

    func createArgsCodec() -> FlutterMessageCodec & NSObjectProtocol {
        return FlutterStandardMessageCodec.sharedInstance()
    }
}

class BannerAdPlatformView: NSObject, FlutterPlatformView {
    private let container: BannerContainerView

    init(frame: CGRect, posId: String, viewController: UIViewController, channel: FlutterMethodChannel) {
        container = BannerContainerView(
            frame: frame, posId: posId, viewController: viewController, channel: channel)
        super.init()
    }

    func view() -> UIView { return container }
}

// 用自定义 UIView，在 layoutSubviews 时才创建 banner，保证宽度不为 0
class BannerContainerView: UIView {
    private let posId: String
    private weak var viewController: UIViewController?
    private let channel: FlutterMethodChannel
    private var bannerManager: SFBannerManager?

    init(frame: CGRect, posId: String, viewController: UIViewController, channel: FlutterMethodChannel) {
        self.posId = posId
        self.viewController = viewController
        self.channel = channel
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

    // 测量 banner 真实内容高度并回传 Flutter 自适应（SDK 未提供固有尺寸时保持当前高度）
    fileprivate func reportHeight() {
        guard let ad = subviews.last else { return }
        var h = ad.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize).height
        if h <= 1 { h = ad.sizeThatFits(CGSize(width: bounds.width, height: 0)).height }
        if h <= 1 { h = ad.frame.height }
        if h > 1 {
            debugPrint("[Banner] reportHeight \(h)")
            channel.invokeMethod("resize", arguments: Double(h))
        }
    }
}

extension BannerContainerView: SFBannerDelegate {
    func bannerAdDidLoad() {
        bannerManager?.showBannerAd(with: self)
        debugPrint("[Banner] 加载成功")
        DispatchQueue.main.async { [weak self] in self?.reportHeight() }
    }
    func bannerAdDidFailed(_ error: Error) {
        debugPrint("[Banner] 加载失败 \(error.localizedDescription)")
    }
    func bannerAdDidClick() {
        channel.invokeMethod("clicked", arguments: nil)
    }
    func bannerAdDidClose() {
        subviews.forEach { $0.removeFromSuperview() }
        channel.invokeMethod("resize", arguments: Double(0)) // 关闭后 Flutter 收起占位
    }
}
