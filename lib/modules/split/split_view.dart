// lib/modules/split/split_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/bill_record.dart';
import 'split_controller.dart';

class SplitView extends StatelessWidget {
  const SplitView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = Get.arguments as BillRecord;
    final ctrl = Get.put(SplitController());
    ctrl.init(bill.amount, bill.note.isEmpty ? '账单分摊' : bill.note);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        title: const Text('账单分摊', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Obx(() => ListView(padding: const EdgeInsets.all(16), children: [
        // 总金额
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Column(children: [
            Text(ctrl.description.value,
                style: const TextStyle(fontSize: 14, color: AppTheme.textSecondary)),
            const SizedBox(height: 4),
            Text('¥${ctrl.totalAmount.value.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppTheme.expenseRed)),
          ]),
        ),
        const SizedBox(height: 16),

        // 人数选择
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('参与人数', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            Row(children: [
              IconButton(
                onPressed: () => ctrl.setMemberCount(ctrl.memberCount.value - 1),
                icon: const Icon(Icons.remove_circle_outline, color: AppTheme.primary),
              ),
              Text('${ctrl.memberCount.value}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              IconButton(
                onPressed: () => ctrl.setMemberCount(ctrl.memberCount.value + 1),
                icon: const Icon(Icons.add_circle_outline, color: AppTheme.primary),
              ),
              const Spacer(),
              Row(children: [
                const Text('自定义金额', style: TextStyle(fontSize: 13)),
                Switch(
                  value: ctrl.isCustom.value,
                  onChanged: ctrl.toggleCustom,
                  activeColor: AppTheme.primary,
                ),
              ]),
            ]),
          ]),
        ),
        const SizedBox(height: 16),

        // 成员列表
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('分摊详情', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            ...ctrl.members.asMap().entries.map((entry) {
              final i = entry.key;
              final m = entry.value;
              return Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Row(children: [
                  GestureDetector(
                    onTap: () => ctrl.togglePaid(i),
                    child: Icon(
                      m.paid ? Icons.check_circle : Icons.radio_button_unchecked,
                      color: m.paid ? AppTheme.incomeGreen : Colors.grey.shade400,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: Text(m.name, style: TextStyle(
                    fontSize: 14,
                    decoration: m.paid ? TextDecoration.lineThrough : null,
                    color: m.paid ? AppTheme.textSecondary : AppTheme.textPrimary,
                  ))),
                  ctrl.isCustom.value
                      ? SizedBox(
                          width: 80,
                          child: TextField(
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              prefixText: '¥', isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                            ),
                            onChanged: (v) => ctrl.setCustomAmount(i, double.tryParse(v) ?? 0),
                          ),
                        )
                      : Text('¥${m.amount.toStringAsFixed(2)}',
                          style: TextStyle(
                            fontSize: 14, fontWeight: FontWeight.w600,
                            color: m.paid ? AppTheme.textSecondary : AppTheme.expenseRed,
                          )),
                ]),
              );
            }),
          ]),
        ),
        const SizedBox(height: 20),

        // 分享按钮
        ElevatedButton.icon(
          onPressed: () => Share.share(ctrl.shareText),
          icon: const Icon(Icons.share_outlined),
          label: const Text('生成分摊单并分享'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primary,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
      ])),
    );
  }
}
