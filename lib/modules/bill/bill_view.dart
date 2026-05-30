import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/bill_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/bill_record.dart';
import '../../router/app_pages.dart';

class BillView extends StatelessWidget {
  const BillView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = BillService.to;
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(bill.currentMonthLabel)),
        actions: [
          IconButton(icon: const Icon(Icons.chevron_left, color: Colors.white),
              onPressed: () => bill.changeMonth(-1)),
          IconButton(icon: const Icon(Icons.chevron_right, color: Colors.white),
              onPressed: () => bill.isCurrentMonth ? null : bill.changeMonth(1)),
        ],
      ),
      body: Obx(() {
        final grouped = bill.billsByDate;
        if (grouped.isEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('💸', style: TextStyle(fontSize: 60)),
                const SizedBox(height: 16),
                const Text('还没有账单', style: TextStyle(fontSize: 18, color: AppTheme.textSecondary)),
                const SizedBox(height: 8),
                const Text('点击右下角 + 记录第一笔账单',
                    style: TextStyle(fontSize: 13, color: Colors.grey)),
              ],
            ),
          );
        }
        final keys = grouped.keys.toList();
        return ListView.builder(
          padding: const EdgeInsets.only(bottom: 80),
          itemCount: keys.length,
          itemBuilder: (_, i) {
            final dateKey = keys[i];
            final items   = grouped[dateKey]!;
            final dayExpense = items.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount);
            final dayIncome  = items.where((b) => !b.isExpense).fold(0.0, (s, b) => s + b.amount);
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 日期分组头
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  color: AppTheme.background,
                  child: Row(
                    children: [
                      Text(dateKey, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13, color: AppTheme.textSecondary)),
                      const Spacer(),
                      if (dayExpense > 0)
                        Text('支出 ¥${dayExpense.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 12, color: AppTheme.expenseRed)),
                      if (dayExpense > 0 && dayIncome > 0) const Text('  ', style: TextStyle(fontSize: 12)),
                      if (dayIncome > 0)
                        Text('收入 ¥${dayIncome.toStringAsFixed(2)}',
                            style: const TextStyle(fontSize: 12, color: AppTheme.incomeGreen)),
                    ],
                  ),
                ),
                ...items.map((b) => _BillItem(record: b, onDelete: () => _confirmDelete(context, b, bill))),
              ],
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.addBill),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _confirmDelete(BuildContext context, BillRecord b, BillService bill) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('删除账单'),
        content: const Text('确认删除这笔账单？'),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
            onPressed: () { bill.deleteBill(b.id); Get.back(); },
            child: const Text('删除', style: TextStyle(color: AppTheme.expenseRed)),
          ),
        ],
      ),
    );
  }
}

class _BillItem extends StatelessWidget {
  final BillRecord record;
  final VoidCallback onDelete;
  const _BillItem({required this.record, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cat = AppConstants.categoryById(record.category);
    return GestureDetector(
      onLongPress: onDelete,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 4, offset: const Offset(0, 1))],
        ),
        child: ListTile(
          leading: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: cat.color.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(child: Text(cat.emoji, style: const TextStyle(fontSize: 22))),
          ),
          title: Text(cat.label, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: record.note.isNotEmpty
              ? Text(record.note, style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1)
              : Text(DateFormat('HH:mm').format(record.date), style: const TextStyle(fontSize: 12, color: Colors.grey)),
          trailing: Text(
            '${record.isExpense ? '-' : '+'}¥${record.amount.toStringAsFixed(2)}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: record.isExpense ? AppTheme.expenseRed : AppTheme.incomeGreen,
            ),
          ),
        ),
      ),
    );
  }
}
