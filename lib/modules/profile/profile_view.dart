import 'package:ads_billtrack/core/services/storage_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/bill_service.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';
import 'profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final ad = AdService.to;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('我的',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
      ),
      body: Column(
        children: [
          // 用户信息卡（固定不滚动）
          Container(
            color: AppTheme.primaryStart,
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 28),
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
          // 可滚动列表区域
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
          const SizedBox(height: 8),
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
          _MenuItem(icon: Icons.account_balance, label: '资产账户', subtitle: '管理账户余额，记账自动增减',
              onTap: () => Get.toNamed(Routes.accounts)),
          _MenuItem(
            icon: Icons.repeat_outlined,
            label: '定期账单',
            subtitle: '管理固定收支，到期一键记录',
            onTap: () => Get.toNamed(Routes.recurring),
          ),
          _MenuItem(icon: Icons.people, label: 'AA 分摊计算器', subtitle: '快速计算多人分摊金额',
              onTap: () => Get.toNamed(Routes.split)),
          _MenuItem(icon: Icons.calendar_today, label: '每日签到', subtitle: '签到赚金币，7天连签额外奖励',
              onTap: () => Get.toNamed(Routes.dailyCheckin)),
          _MenuItem(
            icon: Icons.category_outlined,
            label: '我的分类',
            subtitle: '新增自定义收支分类',
            onTap: () => Get.toNamed(Routes.categoryMgmt),
          ),
          _MenuItem(
            icon: Icons.monitor_heart_outlined,
            label: '财务健康评分',
            subtitle: '查看本月财务健康详细分析',
            onTap: () => Get.toNamed(Routes.healthScore),
          ),
          const SizedBox(height: 8),
          _SectionHeader(title: '数据'),
          _MenuItem(
            icon: Icons.download_outlined,
            label: '导出账单',
            subtitle: '将账单导出为 CSV 文件',
            onTap: () => _showExportDialog(),
          ),
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
          ),
        ],
      ),
    );
  }

  void _showExportDialog() {
    Get.dialog(AlertDialog(
      title: const Text('导出账单'),
      content: const Text('选择导出范围'),
      actionsOverflowButtonSpacing: 4,
      actions: [
        TextButton(onPressed: () { Get.back(); BillService.to.exportBillsAsCsv(); },
            child: const Text('本月')),
        TextButton(onPressed: () { Get.back(); _pickMonth(); },
            child: const Text('选择月份')),
        TextButton(onPressed: () {
            Get.back();
            BillService.to.exportBillsAsCsv(year: DateTime.now().year);
          }, child: const Text('本年')),
        TextButton(onPressed: () { Get.back(); _pickYear(); },
            child: const Text('选择年份')),
        TextButton(onPressed: () { Get.back(); BillService.to.exportBillsAsCsv(allTime: true); },
            child: const Text('全部')),
        TextButton(onPressed: Get.back, child: const Text('取消')),
      ],
    ));
  }

  Future<void> _pickMonth() async {
    final now = DateTime.now();
    final d = await showDatePicker(
      context: Get.context!,
      initialDate: now,
      firstDate: DateTime(2020),
      lastDate: now,
      helpText: '选择导出月份（取所选月）',
    );
    if (d != null) BillService.to.exportBillsAsCsv(month: DateTime(d.year, d.month));
  }

  Future<void> _pickYear() async {
    final now = DateTime.now();
    final years = [for (int y = now.year; y >= 2020; y--) y];
    final picked = await Get.dialog<int>(SimpleDialog(
      title: const Text('选择年份'),
      children: [
        for (final y in years)
          SimpleDialogOption(
            onPressed: () => Get.back(result: y),
            child: Text('$y 年'),
          ),
      ],
    ));
    if (picked != null) BillService.to.exportBillsAsCsv(year: picked);
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
