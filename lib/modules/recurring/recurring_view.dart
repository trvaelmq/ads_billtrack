import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/recurring_rule.dart';
import '../../router/app_pages.dart';
import 'recurring_controller.dart';

class RecurringView extends GetView<RecurringController> {
  const RecurringView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        title: const Text('定期账单', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () => Get.toNamed(Routes.recurringEdit),
          ),
        ],
      ),
      body: Obx(() {
        final rules = controller.rules;
        if (rules.isEmpty) {
          return Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Text('🔄', style: TextStyle(fontSize: 48)),
              const SizedBox(height: 12),
              const Text('暂无定期账单', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
              const SizedBox(height: 6),
              Text('添加房租、工资等固定收支，到期一键记录', style: AppTheme.caption),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => Get.toNamed(Routes.recurringEdit),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, foregroundColor: Colors.white),
                child: const Text('添加定期账单'),
              ),
            ]),
          );
        }
        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          itemCount: rules.length,
          itemBuilder: (_, i) => _RuleCard(rule: rules[i], controller: controller),
        );
      }),
    );
  }
}

class _RuleCard extends StatelessWidget {
  final RecurringRule rule;
  final RecurringController controller;
  const _RuleCard({required this.rule, required this.controller});

  Color get _dueColor {
    final today = DateTime.now();
    final due = rule.nextDueDate;
    final diff = DateTime(due.year, due.month, due.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
    if (diff <= 0) return AppTheme.expenseRed;
    if (diff <= 3) return AppTheme.warnOrange;
    return AppTheme.textSecondary;
  }

  String get _dueLabel {
    final today = DateTime.now();
    final due = rule.nextDueDate;
    final diff = DateTime(due.year, due.month, due.day)
        .difference(DateTime(today.year, today.month, today.day))
        .inDays;
    if (diff < 0) return '已逾期 ${(-diff)} 天';
    if (diff == 0) return '今日到期';
    return '$diff 天后到期';
  }

  String get _freqLabel {
    switch (rule.frequency) {
      case 'daily':   return '每天';
      case 'weekly':  return '每周';
      case 'yearly':  return '每年';
      default:        return '每月';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(rule.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
          color: AppTheme.expenseRed,
          borderRadius: BorderRadius.circular(14),
        ),
        child: const Icon(Icons.delete_outline, color: Colors.white),
      ),
      confirmDismiss: (_) async {
        return await Get.dialog<bool>(AlertDialog(
          title: const Text('删除定期账单'),
          content: Text('确定删除「${rule.title}」？'),
          actions: [
            TextButton(onPressed: () => Get.back(result: false), child: const Text('取消')),
            TextButton(onPressed: () => Get.back(result: true), child: const Text('删除', style: TextStyle(color: Colors.red))),
          ],
        )) ?? false;
      },
      onDismissed: (_) => controller.deleteRule(rule.id),
      child: GestureDetector(
        onTap: () => Get.toNamed(Routes.recurringEdit, arguments: rule),
        child: Container(
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Row(children: [
            Container(
              width: 46, height: 46,
              decoration: BoxDecoration(
                color: (rule.isExpense ? AppTheme.expenseRed : AppTheme.incomeGreen).withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Center(child: Text('🔄', style: TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(rule.title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Row(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(_freqLabel, style: const TextStyle(fontSize: 11, color: AppTheme.primary)),
                ),
                const SizedBox(width: 8),
                Text(_dueLabel, style: TextStyle(fontSize: 12, color: _dueColor)),
              ]),
            ])),
            Text(
              '${rule.isExpense ? '-' : '+'}¥${rule.amount.toStringAsFixed(0)}',
              style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.bold,
                color: rule.isExpense ? AppTheme.expenseRed : AppTheme.incomeGreen,
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
