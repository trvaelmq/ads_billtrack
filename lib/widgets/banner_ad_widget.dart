import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 横幅广告。[height] 仅作初始/占位高度，真实高度由原生渲染后经
/// `com.billtrack/ad_view_<viewId>` 通道回传，自适应重建，避免创意被裁或留白。
class BannerAdWidget extends StatefulWidget {
  final double height;
  final String? posId;
  const BannerAdWidget({super.key, this.height = 60, this.posId});

  @override
  State<BannerAdWidget> createState() => _BannerAdWidgetState();
}

class _BannerAdWidgetState extends State<BannerAdWidget> {
  late double _height = widget.height;

  void _onPlatformViewCreated(int id) {
    MethodChannel('com.billtrack/ad_view_$id').setMethodCallHandler((call) async {
      if (call.method == 'resize') {
        final h = (call.arguments as num).toDouble();
        if (mounted && h >= 0 && h != _height) setState(() => _height = h);
      }
    });
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
