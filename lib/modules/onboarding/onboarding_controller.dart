import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/services/storage_service.dart';
import '../../router/app_pages.dart';

class OnboardingController extends GetxController {
  final nameController = TextEditingController();
  final agreedToPrivacy = false.obs;

  Future<void> openPrivacyPolicy() async {
    final uri = Uri.parse('https://wuhuazizzz.github.io/jileduo/privacy');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('提示', '无法打开隐私政策页面', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> confirm() async {
    if (!agreedToPrivacy.value) return;
    final name = nameController.text.trim();
    await StorageService.setNickname(name.isEmpty ? '用户' : name);
    await StorageService.setJoinDate();
    await StorageService.setFirstLaunchDone();
    Get.offAllNamed(Routes.main);
  }

  @override
  void onClose() {
    nameController.dispose();
    super.onClose();
  }
}
