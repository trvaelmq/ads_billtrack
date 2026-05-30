import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/storage_service.dart';

class ProfileController extends GetxController {
  final ad = AdService.to;
  final nickname = ''.obs;
  String get joinDate => StorageService.joinDate;

  @override
  void onInit() {
    super.onInit();
    nickname.value = StorageService.nickname;
  }

  void editNickname() {
    final controller = TextEditingController(text: nickname.value);
    Get.dialog(
      AlertDialog(
        title: const Text('修改昵称'),
        content: TextField(
          controller: controller,
          autofocus: true,
          maxLength: 16,
          decoration: const InputDecoration(hintText: '输入昵称'),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
            onPressed: () async {
              final name = controller.text.trim();
              await StorageService.setNickname(name.isEmpty ? '用户' : name);
              nickname.value = StorageService.nickname;
              Get.back();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}
