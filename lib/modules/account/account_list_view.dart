import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/services/account_service.dart';
import '../../core/services/auth_service.dart';
import '../../core/theme/app_theme.dart';
import 'account_edit_view.dart';
import 'account_transfer_view.dart';

class AccountListView extends StatelessWidget {
  const AccountListView({super.key});

  @override
  Widget build(BuildContext context) {
    final s = AccountService.to;
    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        elevation: 0,
        title: const Text('资产账户',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(children: [
        Container(
          width: double.infinity,
          color: AppTheme.primaryStart,
          padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('总资产', style: TextStyle(color: Colors.white70, fontSize: 13)),
            const SizedBox(height: 6),
            Obx(() => Text('¥${s.totalAssets.value.toStringAsFixed(2)}',
                style: const TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold))),
          ]),
        ),
        Expanded(child: Obx(() {
          if (s.accounts.isEmpty) {
            return const Center(child: Text('暂无账户，点击下方新增',
                style: TextStyle(color: AppTheme.textSecondary)));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: s.accounts.length,
            separatorBuilder: (_, __) => const SizedBox(height: 10),
            itemBuilder: (_, i) {
              final a = s.accounts[i];
              return Container(
                decoration: AppTheme.cardDecoration,
                child: ListTile(
                  leading: Text(a.emoji, style: const TextStyle(fontSize: 26)),
                  title: Text(a.name, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
                  trailing: Text('¥${a.balance.toStringAsFixed(2)}',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  onTap: () async {
                    if (!await AuthService.to.ensureLoggedIn(message: '管理账户需要登录，是否前往登录？')) return;
                    Get.to(() => AccountEditView(account: a));
                  },
                ),
              );
            },
          );
        })),
        SafeArea(child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 12),
          child: Row(children: [
            Expanded(child: OutlinedButton.icon(
              onPressed: () async {
                if (!await AuthService.to.ensureLoggedIn(message: '账户转账需要登录，是否前往登录？')) return;
                Get.to(() => const AccountTransferView());
              },
              icon: const Icon(Icons.swap_horiz), label: const Text('转账'),
            )),
            const SizedBox(width: 12),
            Expanded(child: ElevatedButton.icon(
              onPressed: () async {
                if (!await AuthService.to.ensureLoggedIn(message: '新增账户需要登录，是否前往登录？')) return;
                Get.to(() => const AccountEditView());
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
              icon: const Icon(Icons.add), label: const Text('新增账户'),
            )),
          ]),
        )),
      ]),
    );
  }
}
