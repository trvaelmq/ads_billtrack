import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 风控 STOP（今日已达上限等）文案统一用弹窗提示，而非一闪而过的 snackbar。
class AppDialogs {
  static void showRiskStop(String message) {
    Get.dialog(
      AlertDialog(
        title: const Text('提示'),
        content: Text(message),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('知道了')),
        ],
      ),
    );
  }
}
