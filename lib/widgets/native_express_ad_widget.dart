import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/ad_config.dart';

/// 原生信息流广告。[height] 仅作初始/占位高度，真实高度由原生渲染后经
/// `com.billtrack/ad_view_<viewId>` 通道回传，自适应重建，避免创意被裁。
class NativeExpressAdWidget extends StatefulWidget {
  final double height;
  final String? posId;

  const NativeExpressAdWidget({super.key, this.height = 300, this.posId});

  @override
  State<NativeExpressAdWidget> createState() => _NativeExpressAdWidgetState();
}

class _NativeExpressAdWidgetState extends State<NativeExpressAdWidget> {
  // UiKitView/AndroidView 创建时尺寸不能为 0，否则原生 view id 状态错乱，
  // 后续 resize 变为非 0 时会抛 PlatformException(recreating_view)。
  static const _minHeight = 1.0;

  late double _height = widget.height < _minHeight ? _minHeight : widget.height;

  void _onPlatformViewCreated(int id) {
    final channel = MethodChannel('com.billtrack/ad_view_$id');
    channel.setMethodCallHandler((call) async {
      if (call.method == 'resize') {
        final h = (call.arguments as num).toDouble();
        if (mounted && h >= 0 && h != _height) setState(() => _height = h);
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
