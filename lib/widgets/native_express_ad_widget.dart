import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../core/constants/ad_config.dart';
import '../modules/home/main_controller.dart';

/// 原生信息流广告。[height] 仅作初始/占位高度，真实高度由原生渲染后经
/// `com.billtrack/ad_view_<viewId>` 通道回传，自适应重建，避免创意被裁。
///
/// [tabIndex]：如果这个广告位放在底部导航的常驻 Tab 页面里（[IndexedStack] 不会销毁重建），
/// 传入对应的 Tab 下标——加载失败时，下次切回这个 Tab 会自动重试一次；不传就没有这个重试。
class NativeExpressAdWidget extends StatefulWidget {
  final double height;
  final String? posId;
  final int? tabIndex;

  const NativeExpressAdWidget({
    super.key,
    this.height = 300,
    this.posId,
    this.tabIndex,
  });

  @override
  State<NativeExpressAdWidget> createState() => _NativeExpressAdWidgetState();
}

class _NativeExpressAdWidgetState extends State<NativeExpressAdWidget> {
  // UiKitView/AndroidView 创建时尺寸不能为 0，否则原生 view id 状态错乱，
  // 后续 resize 变为非 0 时会抛 PlatformException(recreating_view)。
  static const _minHeight = 1.0;

  late double _height = widget.height < _minHeight ? _minHeight : widget.height;
  MethodChannel? _channel;
  bool _failed = false;
  Worker? _tabWorker;

  @override
  void initState() {
    super.initState();
    final tabIndex = widget.tabIndex;
    if (tabIndex != null && Get.isRegistered<MainController>()) {
      _tabWorker = ever<int>(MainController.to.currentIndex, (idx) {
        if (idx == tabIndex && _failed) _reload();
      });
    }
  }

  void _onPlatformViewCreated(int id) {
    final channel = MethodChannel('com.billtrack/ad_view_$id');
    _channel = channel;
    channel.setMethodCallHandler((call) async {
      if (call.method == 'resize') {
        final h = (call.arguments as num).toDouble();
        _failed = false;
        if (mounted && h >= 0 && h != _height) setState(() => _height = h);
      } else if (call.method == 'loadFailed') {
        debugPrint('[NativeExpressAdWidget] loadFailed: ${call.arguments}');
        _failed = true;
      }
    });
    // 原生渲染可能早于 handler 注册完成而丢失 resize 推送，主动查询一次兜底
    _queryHeight(channel);
  }

  Future<void> _queryHeight(MethodChannel channel) async {
    try {
      final h = await channel.invokeMethod<double>('queryHeight');
      if (mounted && h != null && h >= 0 && h != _height) setState(() => _height = h);
    } catch (_) {}
  }

  void _reload() {
    _failed = false;
    _channel?.invokeMethod('reload');
  }

  @override
  void dispose() {
    _tabWorker?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final args = <String, dynamic>{
      'posId': widget.posId ?? AdConfig.detailBannerPosId,
      'width': w.toInt(),
      'height': widget.height.toInt(),
    };
    Widget? platformView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      platformView = UiKitView(
        viewType: 'com.billtrack/native_express_ad',
        layoutDirection: TextDirection.ltr,
        creationParams: args,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      platformView = AndroidView(
        viewType: 'com.billtrack/native_express_ad',
        layoutDirection: TextDirection.ltr,
        creationParams: args,
        creationParamsCodec: const StandardMessageCodec(),
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    if (platformView == null) return const SizedBox.shrink();
    // 不做尺寸过渡动画：原生内容一到位就同帧摆好容器高度，避免动画期间
    // 内容已撑到位、容器还在过渡导致的视觉溢出。
    return SizedBox(height: _height, child: platformView);
  }
}
