// lib/modules/auth/register_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        title: const Text('注册',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          TextField(
            controller: controller.usernameController,
            decoration: const InputDecoration(
              labelText: '用户名 *',
              helperText: '3-50个字符，仅限字母、数字、下划线',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: '密码 *',
              helperText: '6-100个字符',
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.confirmController,
            obscureText: true,
            decoration: const InputDecoration(
              labelText: '确认密码 *',
              prefixIcon: Icon(Icons.lock_outline),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.phoneController,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              labelText: '手机号（选填）',
              prefixIcon: Icon(Icons.phone_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              labelText: '邮箱（选填）',
              prefixIcon: Icon(Icons.email_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.nicknameController,
            decoration: const InputDecoration(
              labelText: '昵称（选填，默认取用户名）',
              prefixIcon: Icon(Icons.badge_outlined),
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: controller.invitationCodeController,
            decoration: const InputDecoration(
              labelText: '邀请码（选填）',
              prefixIcon: Icon(Icons.card_giftcard_outlined),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: controller.agreedToPrivacy.value,
                      onChanged: (v) =>
                          controller.agreedToPrivacy.value = v ?? false,
                      activeColor: AppTheme.primary,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.agreedToPrivacy.value =
                          !controller.agreedToPrivacy.value,
                      child: Row(
                        children: [
                          const Text('我已阅读并同意',
                              style: TextStyle(
                                  color: AppTheme.textSecondary, fontSize: 13)),
                          GestureDetector(
                            onTap: controller.openPrivacyPolicy,
                            child: const Text(
                              '《隐私政策》',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                                decorationColor: AppTheme.primary,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          const SizedBox(height: 16),
          Obx(() => SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed:
                      controller.loading.value || !controller.agreedToPrivacy.value
                          ? null
                          : controller.submit,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryStart,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                  ),
                  child: controller.loading.value
                      ? const SizedBox(
                          width: 22, height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2))
                      : const Text('注册并登录',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              )),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
