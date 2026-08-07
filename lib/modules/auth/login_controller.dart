// lib/modules/auth/login_controller.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/utils/app_dialogs.dart';
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
      final name = AuthService.to.userInfo.value?.nickname ?? username;
      // 栈里真的还有上一页（如从闸门 push 进入）才 pop 回去并回传结果，让原操作自动继续；
      // 否则（独立进入，或栈已被 offAllNamed 清空，如风控强制登出后重新登录）跳首页。
      // 注意：不能用 Get.previousRoute.isNotEmpty 判断——offAllNamed 清栈后它仍可能返回清栈前的
      // 陈旧路由名，导致这里误判为"能返回"，实际 Get.back() 因栈内只有登录页而静默不跳转。
      if (Get.key.currentState?.canPop() ?? false) {
        Get.back(result: true);
      } else {
        Get.offAllNamed(Routes.main);
      }
      Get.snackbar('登录成功', '欢迎回来，$name', snackPosition: SnackPosition.BOTTOM);
      final stopMessage = AuthService.to.riskStopMessage.value;
      if (stopMessage != null) {
        AuthService.to.riskStopMessage.value = null;
        AppDialogs.showRiskStop(stopMessage);
      }
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
