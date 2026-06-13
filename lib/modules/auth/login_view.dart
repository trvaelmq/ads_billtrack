// lib/modules/auth/login_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';
import 'login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // 强制登录：屏蔽系统返回键，未登录不可退出到首页或退出应用
    return PopScope(
      canPop: false,
      child: Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        automaticallyImplyLeading: false,
        title: const Text('登录',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const SizedBox(height: 16),
          Center(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.asset('assets/app_icon.png', width: 80, height: 80),
            ),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: controller.usernameController,
            decoration: const InputDecoration(
              labelText: '用户名',
              prefixIcon: Icon(Icons.person_outline),
            ),
          ),
          const SizedBox(height: 16),
          Obx(() => TextField(
                controller: controller.passwordController,
                obscureText: controller.obscure.value,
                decoration: InputDecoration(
                  labelText: '密码',
                  prefixIcon: const Icon(Icons.lock_outline),
                  suffixIcon: IconButton(
                    icon: Icon(controller.obscure.value
                        ? Icons.visibility_off
                        : Icons.visibility),
                    onPressed: () =>
                        controller.obscure.value = !controller.obscure.value,
                  ),
                ),
              )),
          const SizedBox(height: 32),
          Obx(() => SizedBox(
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.loading.value ? null : controller.submit,
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
                      : const Text('登录',
                          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              )),
          const SizedBox(height: 16),
          TextButton(
            onPressed: () => Get.toNamed(Routes.register),
            child: const Text('没有账号？去注册',
                style: TextStyle(color: AppTheme.primary)),
          ),
        ],
      ),
      ),
    );
  }
}
