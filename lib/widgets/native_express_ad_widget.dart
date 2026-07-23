import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/ad_config.dart';
import '../core/constants/risk_config.dart';
import '../core/services/risk/risk_gate_service.dart';

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
  late double _height = widget.height;

  void _onPlatformViewCreated(int id) {
    MethodChannel('com.billtrack/ad_view_$id').setMethodCallHandler((call) async {
      if (call.method == 'resize') {
        final h = (call.arguments as num).toDouble();
        if (mounted && h >= 0 && h != _height) setState(() => _height = h);
      } else if (call.method == 'clicked') {
        RiskGateService.to
            .reportEvent(adFormat: RiskAdFormat.feed, eventType: RiskEventType.click);
      }
    });
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
    return AnimatedSize(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      child: SizedBox(height: _height, child: platformView),
    );
  }
}
