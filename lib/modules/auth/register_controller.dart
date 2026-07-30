// lib/modules/auth/register_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
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
  final invitationCodeController = TextEditingController();
  final loading = false.obs;
  final agreedToPrivacy = false.obs;

  Future<void> openPrivacyPolicy() async {
    final uri = Uri.parse('https://wuhuazizzz.github.io/jileduo/privacy');
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      Get.snackbar('提示', '无法打开隐私政策页面', snackPosition: SnackPosition.BOTTOM);
    }
  }

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
      invitationCode: invitationCodeController.text.trim(),
    );
    loading.value = false;
    if (result.success) {
      // 注册并自动登录成功：直接进入首页（登录页为栈底根页）
      Get.offAllNamed(Routes.main);
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
    invitationCodeController.dispose();
    super.onClose();
  }
}
