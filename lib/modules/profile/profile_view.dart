import 'package:ads_billtrack/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/services/ad_service.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ad = AdService.to;
    return Scaffold(
      appBar: AppBar(title: const Text('我的')),
      body: ListView(
        children: [
          // 用户信息卡
          Container(
            color: AppTheme.primary,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 32),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: Colors.white.withValues(alpha: 0.2),
                  child: ClipOval(
                    child: Image.asset('assets/app_icon_source.png', width: 60, height: 60),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: GestureDetector(
                    onTap: (){
                      if (!StorageService.isProfileSet) {
                        Get.toNamed(Routes.onboarding);
                      }else{
                        // controller.editNickname();
                      }
                    },
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Obx(() => Text(controller.nickname.value,
                                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20))),
                            const SizedBox(width: 6),
                            const Icon(Icons.edit, color: Colors.white54, size: 16),
                          ],
                        ),
                        Text(
                          '加入于 ${DateFormat('yyyy年MM月').format(DateTime.parse(controller.joinDate))}',
                          style: const TextStyle(color: Colors.white70, fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ),
                Obx(() => Column(
                      children: [
                        const Text('🪙', style: TextStyle(fontSize: 24)),
                        Text('${ad.totalCoins.value}',
                            style: const TextStyle(color: AppTheme.coinGold, fontWeight: FontWeight.bold, fontSize: 16)),
                        const Text('金币', style: TextStyle(color: Colors.white70, fontSize: 11)),
                      ],
                    )),
              ],
            ),
          ),
          const SizedBox(height: 8),
          // 功能入口
          _SectionHeader(title: '财务工具'),
          _MenuItem(icon: Icons.bar_chart, label: '统计分析', subtitle: '查看收支分布和月度趋势',
              onTap: () {
                if (!StorageService.isProfileSet) {
                  Get.toNamed(Routes.onboarding);
                }else{
                  Get.toNamed(Routes.stats);
                }
              }),
          _MenuItem(icon: Icons.account_balance_wallet, label: '预算管理', subtitle: '设置各类别月度预算',
              onTap: () => Get.toNamed(Routes.budget)),
          _MenuItem(icon: Icons.people, label: 'AA 分摊计算器', subtitle: '快速计算多人分摊金额',
              onTap: () => Get.toNamed(Routes.split)),
          _MenuItem(icon: Icons.calendar_today, label: '每日签到', subtitle: '签到赚金币，7天连签额外奖励',
              onTap: () => Get.toNamed(Routes.dailyCheckin)),
          const SizedBox(height: 8),
          _SectionHeader(title: '数据'),
          _MenuItem(
            icon: Icons.info_outline,
            label: '隐私政策',
            subtitle: '',
            onTap: ()async{      
              if (!await launchUrl(Uri.parse("https://wuhuazizzz.github.io/jileduo/privacy"))) {
                throw Exception('Could not launch ${Uri.parse("https://wuhuazizzz.github.io/jileduo/privacy")}');
              } 
            } ,
          ),
          _MenuItem(
            icon: Icons.info_outline,
            label: '关于记乐多',
            subtitle: 'MoneyLog v1.0.0',
            onTap: () => showAboutDialog(context: context, applicationName: '记乐多 · MoneyLog', applicationVersion: '1.0.0'),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  const _SectionHeader({required this.title});

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
        child: Text(title,
            style: const TextStyle(color: AppTheme.textSecondary, fontSize: 12, fontWeight: FontWeight.bold)),
      );
}

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;
  const _MenuItem({required this.icon, required this.label, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) => Container(
        color: Colors.white,
        child: ListTile(
          leading: Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: AppTheme.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(10)),
            child: Icon(icon, color: AppTheme.primary, size: 20),
          ),
          title: Text(label, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
          subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
          trailing: const Icon(Icons.chevron_right, color: Colors.grey),
          onTap: onTap,
        ),
      );
}
