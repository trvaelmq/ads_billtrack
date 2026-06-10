// lib/modules/auth/register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../router/app_pages.dart';
import 'auth_validators.dart';

class RegisterController extends GetxController {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final nicknameController = TextEditingController();
  final loading = false.obs;

  String? _validate() {
    return AuthValidators.username(usernameController.text.trim()) ??
        AuthValidators.password(passwordController.text) ??
        AuthValidators.confirmPassword(
            passwordController.text, confirmController.text) ??
        AuthValidators.phone(phoneController.text.trim()) ??
        AuthValidators.email(emailController.text.trim()) ??
        AuthValidators.nickname(nicknameController.text.trim());
  }

  Future<void> submit() async {
    final err = _validate();
    if (err != null) {
      Get.snackbar('提示', err, snackPosition: SnackPosition.BOTTOM);
      return;
    }
    loading.value = true;
    final result = await AuthService.to.register(
      username: usernameController.text.trim(),
      password: passwordController.text,
      phone: phoneController.text.trim(),
      email: emailController.text.trim(),
      nickname: nicknameController.text.trim(),
    );
    loading.value = false;
    if (result.success) {
      // 注册并自动登录成功：弹出注册页和登录页，回到来源页
      Get.until((route) {
        final name = route.settings.name;
        return name != Routes.register && name != Routes.login;
      });
      Get.snackbar('注册成功', '已自动登录', snackPosition: SnackPosition.BOTTOM);
    } else {
      Get.snackbar('注册失败', result.message, snackPosition: SnackPosition.BOTTOM);
    }
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    phoneController.dispose();
    emailController.dispose();
    nicknameController.dispose();
    super.onClose();
  }
}
