import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/storage_service.dart';

class StatsController extends GetxController {
  final bill = BillService.to;

  @override
  void onReady() {
    super.onReady();
    if (!StorageService.isProfileSet) {
      _showLoginPrompt();
    }
  }

  void _showLoginPrompt() {
    final ctrl = TextEditingController();
    Get.dialog(
      AlertDialog(
        title: const Text('设置昵称后解锁统计'),
        content: TextField(
          controller: ctrl,
          autofocus: true,
          maxLength: 16,
          decoration: const InputDecoration(hintText: '输入你的昵称'),
        ),
        actions: [
          TextButton(
            onPressed: () { Get.back(); Get.back(); },
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () async {
              final name = ctrl.text.trim();
              if (name.isEmpty) return;
              await StorageService.setNickname(name);
              await StorageService.setJoinDate();
              Get.back();
            },
            child: const Text('确定'),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

}
