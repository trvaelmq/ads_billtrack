import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/ad_config.dart';

class NativeExpressAdWidget extends StatelessWidget {
  final double height;
  final String? posId;

  const NativeExpressAdWidget({super.key, this.height = 300, this.posId});

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final args = <String, dynamic>{
      'posId': posId ?? AdConfig.detailBannerPosId,
      'width': w.toInt(),
      'height': height.toInt(),
    };
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        height: height,
        child: UiKitView(
          viewType: 'com.billtrack/native_express_ad',
          layoutDirection: TextDirection.ltr,
          creationParams: args,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        height: height,
        child: AndroidView(
          viewType: 'com.billtrack/native_express_ad',
          layoutDirection: TextDirection.ltr,
          creationParams: args,
          creationParamsCodec: const StandardMessageCodec(),
          gestureRecognizers: const <Factory<OneSequenceGestureRecognizer>>{},
        ),
      );
    }
    return const SizedBox.shrink();
  }
}
