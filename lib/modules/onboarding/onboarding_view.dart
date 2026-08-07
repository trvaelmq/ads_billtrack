import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import 'onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.primary,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset('assets/app_icon.png', width: 80, height: 80),
              ),
              const SizedBox(height: 16),
              const Text('欢迎使用\n智探眼',
                  style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold, height: 1.4)),
              // const SizedBox(height: 8),
              // const Text('随手记账，看广告解锁更多功能',
              //     style: TextStyle(color: Colors.white70, fontSize: 15)),
              const SizedBox(height: 48),
              Obx(() => SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.agreedToPrivacy.value ? controller.confirm : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.coinGold,
                    foregroundColor: Colors.white,
                    disabledBackgroundColor: Colors.white24,
                    disabledForegroundColor: Colors.white54,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                  ),
                  child: const Text('开始记账', style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold)),
                ),
              )),
              const SizedBox(height: 16),
              Obx(() => Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: Checkbox(
                      value: controller.agreedToPrivacy.value,
                      onChanged: (v) => controller.agreedToPrivacy.value = v ?? false,
                      activeColor: AppTheme.coinGold,
                      side: const BorderSide(color: Colors.white54),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => controller.agreedToPrivacy.value = !controller.agreedToPrivacy.value,
                      child: Row(
                        children: [
                          const Text('我已阅读并同意', style: TextStyle(color: Colors.white70, fontSize: 13)),
                          GestureDetector(
                            onTap: controller.openPrivacyPolicy,
                            child: const Text(
                              '《隐私政策》',
                              style: TextStyle(
                                color: AppTheme.coinGold,
                                fontSize: 13,
                                decoration: TextDecoration.underline,
                                decorationColor: AppTheme.coinGold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )),
            ],
          ),
        ),
      ),
    );
  }
}
