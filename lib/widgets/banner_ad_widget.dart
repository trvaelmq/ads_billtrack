import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/constants/ad_config.dart';

class BannerAdWidget extends StatelessWidget {
  final double height;
  final String? posId;
  const BannerAdWidget({super.key, this.height = 60, this.posId});

  @override
  Widget build(BuildContext context) {
    final args = <String, dynamic>{
      if (posId != null) 'posId': posId,
      'floor': AdConfig.bannerFloor,
    };
    if (defaultTargetPlatform == TargetPlatform.iOS) {
      return SizedBox(
        height: height,
        child: UiKitView(
          viewType: 'com.billtrack/banner_ad',
          layoutDirection: TextDirection.ltr,
          creationParams: args,
          creationParamsCodec: const StandardMessageCodec(),
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.android) {
      return SizedBox(
        height: height,
        child: AndroidView(
          viewType: 'com.billtrack/banner_ad',
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
