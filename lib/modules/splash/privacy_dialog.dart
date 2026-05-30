import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/theme/app_theme.dart';

class PrivacyDialog extends StatelessWidget {
  const PrivacyDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      title: const Text('隐私政策', style: TextStyle(fontWeight: FontWeight.bold)),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              '感谢您使用记乐多 · MoneyLog。\n\n'
              '我们非常重视您的个人信息与隐私保护。在您开始使用前，请仔细阅读我们的隐私政策。\n\n'
              '主要内容包括：\n'
              '• 我们收集的信息及用途\n'
              '• 应用集成的广告 SDK（优量汇）可能采集设备标识符等信息用于广告投放\n'
              '• 您的权利及联系方式\n',
              style: TextStyle(fontSize: 14, height: 1.5),
            ),
            GestureDetector(
              onTap: () async {
                final uri = Uri.parse('https://wuhuazizzz.github.io/jileduo/privacy');
                if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
                  Get.snackbar('提示', '无法打开隐私政策页面', snackPosition: SnackPosition.BOTTOM);
                }
              },
              child: const Text(
                '查看完整《隐私政策》',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontSize: 14,
                  decoration: TextDecoration.underline,
                  decorationColor: AppTheme.primary,
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Get.back(result: false),
          child: const Text('不同意', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          onPressed: () => Get.back(result: true),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('同意并继续'),
        ),
      ],
    );
  }
}
