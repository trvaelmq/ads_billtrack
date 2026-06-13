// lib/modules/auth/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../router/app_pages.dart';

class LoginController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final loading = false.obs;
  final obscure = true.obs;

  Future<void> submit() async {
    final username = usernameController.text.trim();
    final password = passwordController.text;
    if (username.isEmpty || password.isEmpty) {
      Get.snackbar('提示', '请输入用户名和密码', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    loading.value = true;
    final result = await AuthService.to.login(username, password);
    loading.value = false;
    if (result.success) {
      // 登录页为栈底根页，登录成功后进入首页
      Get.offAllNamed(Routes.main);
      final name = AuthService.to.userInfo.value?.nickname ?? username;
      Get.snackbar('登录成功', '欢迎回来，$name', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('登录失败', result.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
