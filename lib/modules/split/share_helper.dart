// lib/modules/split/share_helper.dart
import 'package:flutter/widgets.dart';
import 'package:share_plus/share_plus.dart';

/// 分享文本，并基于 [box] 提供 sharePositionOrigin。
///
/// iPad / 部分 iOS 形态下，系统分享面板是 popover，必须给一个非零的锚点矩形，
/// 否则 share_plus 会抛 PlatformException（"sharePositionOrigin: argument must be set"）。
///
/// 传入调用方控件的 RenderBox（由 `context.findRenderObject()` 在 await 之前取得，
/// 避免跨异步使用 BuildContext）。
Future<void> shareWithOrigin(RenderBox? box, String text) async {
  final origin = (box != null && box.hasSize)
      ? box.localToGlobal(Offset.zero) & box.size
      : null;
  await Share.share(text, sharePositionOrigin: origin);
}
