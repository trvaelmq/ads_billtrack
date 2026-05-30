import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/theme/app_theme.dart';
import 'budget_detail_controller.dart';

class BudgetDetailView extends GetView<BudgetDetailController> {
  const BudgetDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final cat = controller.cat;

    return Scaffold(
      appBar: AppBar(
        title: Text('${cat.emoji} ${cat.label}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined, color: Colors.white),
            tooltip: '修改预算',
            onPressed: () => _showEditDialog(context),
          ),
        ],
      ),
      body: Obx(() {
        final budget  = controller.budget.value;
        final spent   = controller.spent;
        final bills   = controller.categoryBills;
        final over    = budget > 0 && spent > budget;
        final ratio   = budget > 0 ? (spent / budget).clamp(0.0, 1.0) : 0.0;
        final barColor = ratio < 0.8
            ? cat.color
            : ratio < 1.0 ? Colors.orange : AppTheme.expenseRed;

        return ListView(
          children: [
            // ── 摘要卡片 ────────────────────────────────────────────
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: cat.color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: cat.color.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  // 支出 / 预算 数字行
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _StatBox(
                        label: '本月已支出',
                        value: '¥${spent.toStringAsFixed(2)}',
                        valueColor: over ? AppTheme.expenseRed : AppTheme.textPrimary,
                      ),
                      _StatBox(
                        label: '月度预算',
                        value: budget > 0 ? '¥${budget.toStringAsFixed(0)}' : '未设置',
                        valueColor: AppTheme.textPrimary,
                        onTap: () => _showEditDialog(context),
                        suffix: const Icon(Icons.edit_outlined, size: 14, color: AppTheme.textSecondary),
                      ),
                      _StatBox(
                        label: over ? '超出预算' : '剩余可用',
                        value: budget > 0
                            ? '${over ? '+' : ''}¥${(spent - budget).abs().toStringAsFixed(0)}'
                            : '—',
                        valueColor: budget > 0
                            ? (over ? AppTheme.expenseRed : AppTheme.incomeGreen)
                            : AppTheme.textSecondary,
                      ),
                    ],
                  ),
                  if (budget > 0) ...[
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            child: LinearProgressIndicator(
                              value: ratio,
                              minHeight: 10,
                              backgroundColor: Colors.white,
                              valueColor: AlwaysStoppedAnimation<Color>(barColor),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          '${(ratio * 100).toStringAsFixed(0)}%',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: barColor,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    if (over)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            const Icon(Icons.warning_amber_rounded,
                                color: AppTheme.expenseRed, size: 16),
                            const SizedBox(width: 6),
                            Text(
                              '已超出本月预算 ¥${(spent - budget).toStringAsFixed(2)}',
                              style: const TextStyle(
                                  color: AppTheme.expenseRed, fontSize: 13),
                            ),
                          ],
                        ),
                      ),
                  ],
                ],
              ),
            ),

            // ── 账单列表 ─────────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 8),
              child: Row(
                children: [
                  const Text('本月账单',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Text('共 ${bills.length} 笔',
                      style: const TextStyle(
                          fontSize: 13, color: AppTheme.textSecondary)),
                ],
              ),
            ),

            if (bills.isEmpty)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 48),
                child: Center(
                  child: Text('本月暂无该分类账单',
                      style: TextStyle(color: AppTheme.textSecondary)),
                ),
              )
            else
              ...bills.map((b) => _BillItem(
                    emoji: cat.emoji,
                    note:  b.note.isNotEmpty ? b.note : cat.label,
                    date:  b.date,
                    amount: b.amount,
                    color: cat.color,
                  )),

            const SizedBox(height: 32),
          ],
        );
      }),
    );
  }

  void _showEditDialog(BuildContext context) {
    final tc = TextEditingController(
        text: controller.budget.value > 0
            ? controller.budget.value.toStringAsFixed(0)
            : '');
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('${controller.cat.emoji} ${controller.cat.label} 月度预算'),
        content: TextField(
          controller: tc,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          decoration: const InputDecoration(prefixText: '¥ ', hintText: '0 = 不限制'),
          autofocus: true,
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('取消')),
          TextButton(
            onPressed: () {
              final v = double.tryParse(tc.text.trim()) ?? 0;
              controller.setBudget(v);
              Get.back();
            },
            child: const Text('保存'),
          ),
        ],
      ),
    );
  }
}

// ── 数字统计格子 ────────────────────────────────────────────────────
class _StatBox extends StatelessWidget {
  final String label, value;
  final Color valueColor;
  final VoidCallback? onTap;
  final Widget? suffix;

  const _StatBox({
    required this.label, required this.value, required this.valueColor,
    this.onTap, this.suffix,
  });

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 12, color: AppTheme.textSecondary)),
            const SizedBox(height: 6),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(value,
                    style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: valueColor)),
                if (suffix != null) ...[
                  const SizedBox(width: 3),
                  suffix!,
                ],
              ],
            ),
          ],
        ),
      );
}

// ── 单条账单 ────────────────────────────────────────────────────────
class _BillItem extends StatelessWidget {
  final String emoji, note;
  final DateTime date;
  final double amount;
  final Color color;

  const _BillItem({
    required this.emoji, required this.note,
    required this.date, required this.amount, required this.color,
  });

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 4,
                offset: const Offset(0, 1))
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                  child: Text(emoji, style: const TextStyle(fontSize: 20))),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(note,
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w500)),
                  const SizedBox(height: 2),
                  Text(
                    DateFormat('MM月dd日 HH:mm').format(date),
                    style: const TextStyle(
                        fontSize: 12, color: AppTheme.textSecondary),
                  ),
                ],
              ),
            ),
            Text(
              '-¥${amount.toStringAsFixed(2)}',
              style: const TextStyle(
                  color: AppTheme.expenseRed,
                  fontWeight: FontWeight.bold,
                  fontSize: 15),
            ),
          ],
        ),
      );
}
