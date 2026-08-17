import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../modules/home/main_controller.dart';

/// 横幅广告。[height] 仅作初始/占位高度，真实高度由原生渲染后经
/// `com.billtrack/ad_view_<viewId>` 通道回传，自适应重建，避免创意被裁或留白。
///
/// [tabIndex]：如果这个广告位放在底部导航的常驻 Tab 页面里（[IndexedStack] 不会销毁重建），
/// 传入对应的 Tab 下标——加载失败时，下次切回这个 Tab 会自动重试一次；不传就没有这个重试。
class BannerAdWidget extends StatefulWidget {
  final double height;
  final String? posId;
  final int? tabIndex;
  const BannerAdWidget({super.key, this.height = 60, this.posId, this.tabIndex});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late double _height = widget.height;
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
        debugPrint('[BannerAdWidget] loadFailed: ${call.arguments}');
        _failed = true;
      }
    });
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
    final args = <String, dynamic>{
      if (widget.posId != null) 'posId': widget.posId,
    };
    Widget? platformView;
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      platformView = UiKitView(
        viewType: 'com.billtrack/banner_ad',
        layoutDirection: TextDirection.ltr,
        creationParams: args,
        creationParamsCodec: const StandardMessageCodec(),
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      platformView = AndroidView(
        viewType: 'com.billtrack/banner_ad',
        layoutDirection: TextDirection.ltr,
        creationParams: args,
        creationParamsCodec: const StandardMessageCodec(),
        gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        onPlatformViewCreated: _onPlatformViewCreated,
      );
    }
    if (platformView == null) return const SizedBox.shrink();
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: SizedBox(height: _height, child: platformView),
    );
  }
}
