import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';
import '../../widgets/animated_counter.dart';
import 'report_controller.dart';

class ReportView extends GetView<ReportController> {
  const ReportView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = controller.bill;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Obx(() => Text(bill.currentMonthLabel,
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600))),
        actions: [
          IconButton(
            icon: const Icon(Icons.chevron_left, color: Colors.white),
            onPressed: () => bill.changeMonth(-1),
          ),
          Obx(() => IconButton(
            icon: Icon(Icons.chevron_right,
                color: bill.isCurrentMonth ? Colors.white30 : Colors.white),
            onPressed: bill.isCurrentMonth ? null : () => bill.changeMonth(1),
          )),
        ],
      ),
      body: Obx(() {
        final expense     = bill.monthlyExpense.value;
        final income      = bill.monthlyIncome.value;
        final net         = income - expense;
        final lastExp     = controller.lastMonthExpense;
        final lastInc     = controller.lastMonthIncome;
        final expenses    = bill.expenseByCategory;
        final budgets     = controller.budgets;
        final hasBudget   = budgets.isNotEmpty;

        return Column(children: [
          Container(
            height: MediaQuery.of(context).padding.top + 56,
            decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 32),
              children: [
                // ── 月报告卡片 ────────────────────────────────────────────
                _SectionTitle(title: '月度报告'),
                const SizedBox(height: 8),
                _MonthReportCard(
                  expense: expense, income: income, net: net,
                  lastExpense: lastExp, lastIncome: lastInc,
                ),
                const SizedBox(height: 20),

                // ── 预算进度 ──────────────────────────────────────────────
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const _SectionTitle(title: '预算进度'),
                    TextButton.icon(
                      onPressed: controller.goToBudget,
                      icon: const Icon(Icons.edit_outlined, size: 14),
                      label: const Text('管理预算', style: TextStyle(fontSize: 13)),
                      style: TextButton.styleFrom(foregroundColor: AppTheme.primary),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                if (!hasBudget)
                  _EmptyBudgetHint(onTap: controller.goToBudget)
                else
                  ...AppConstants.expenseCategories
                      .where((cat) => (budgets[cat.id] ?? 0) > 0)
                      .toList()
                      .asMap()
                      .entries
                      .map((entry) {
                    final cat = entry.value;
                    final rowIndex = entry.key;
                    final spent  = expenses[cat.id] ?? 0;
                    final budget = budgets[cat.id]!;
                    return _BudgetRow(
                      emoji:    cat.emoji,
                      label:    cat.label,
                      color:    cat.color,
                      spent:    spent,
                      budget:   budget,
                      rowIndex: rowIndex,
                      onTap: () async {
                        await Get.toNamed(Routes.budgetDetail, arguments: cat.id);
                        controller.refreshBudgets();
                      },
                    );
                  }),

                // 未设预算分类简览
                if (hasBudget) ...[
                  const SizedBox(height: 16),
                  _UnsetCategories(
                    expenses: expenses,
                    budgets: budgets,
                    onTap: controller.goToBudget,
                  ),
                ],
              ],
            ),
          ),
        ]);
      }),
    );
  }

}

// ── 区块标题 ────────────────────────────────────────────────────────
class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle({required this.title});

  @override
  Widget build(BuildContext context) => Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          color: AppTheme.textPrimary,
        ),
      );
}

// ── 月报告卡片 ──────────────────────────────────────────────────────
class _MonthReportCard extends StatelessWidget {
  final double expense, income, net, lastExpense, lastIncome;
  const _MonthReportCard({
    required this.expense, required this.income, required this.net,
    required this.lastExpense, required this.lastIncome,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppTheme.primary, AppTheme.secondary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          // 结余大数字
          Column(
            children: [
              const Text('本月结余', style: TextStyle(color: Colors.white70, fontSize: 13)),
              const SizedBox(height: 4),
              Text(
                '${net >= 0 ? '+' : ''}¥${net.toStringAsFixed(2)}',
                style: TextStyle(
                  color: net >= 0 ? const Color(0xFFB9F6CA) : const Color(0xFFFFCDD2),
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(color: Colors.white24, height: 1),
          const SizedBox(height: 16),
          // 支出 / 收入 对比行
          Row(
            children: [
              Expanded(child: _ReportStat(
                label: '支出',
                value: expense,
                color: const Color(0xFFFFCDD2),
                lastValue: lastExpense,
                isExpense: true,
              )),
              Container(width: 1, height: 48, color: Colors.white24),
              Expanded(child: _ReportStat(
                label: '收入',
                value: income,
                color: const Color(0xFFB9F6CA),
                lastValue: lastIncome,
                isExpense: false,
              )),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportStat extends StatelessWidget {
  final String label;
  final double value, lastValue;
  final Color color;
  final bool isExpense;
  const _ReportStat({
    required this.label, required this.value,
    required this.lastValue, required this.color, required this.isExpense,
  });

  @override
  Widget build(BuildContext context) {
    final diff   = value - lastValue;
    final hasRef = lastValue > 0;
    // 支出：涨了是坏事（红），收入：涨了是好事（绿）
    final isUp   = diff > 0;
    final trendColor = isExpense
        ? (isUp ? const Color(0xFFFFCDD2) : const Color(0xFFB9F6CA))
        : (isUp ? const Color(0xFFB9F6CA) : const Color(0xFFFFCDD2));

    return Column(
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
        const SizedBox(height: 6),
        AnimatedCounter(
          value: value,
          style: TextStyle(color: color, fontSize: 20, fontWeight: FontWeight.bold),
          decimalPlaces: 0,
        ),
        if (hasRef) ...[
          const SizedBox(height: 4),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(isUp ? Icons.arrow_upward : Icons.arrow_downward,
                  color: trendColor, size: 12),
              Text(
                '¥${diff.abs().toStringAsFixed(0)} 较上月',
                style: TextStyle(color: trendColor, fontSize: 11),
              ),
            ],
          ),
        ],
      ],
    );
  }
}

// ── 单条预算进度 ────────────────────────────────────────────────────
class _BudgetRow extends StatelessWidget {
  final String emoji, label;
  final Color color;
  final double spent, budget;
  final int rowIndex;
  final VoidCallback onTap;
  const _BudgetRow({
    required this.emoji, required this.label, required this.color,
    required this.spent, required this.budget, required this.rowIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final ratio    = (spent / budget).clamp(0.0, 1.0);
    final over     = spent > budget;
    final pct      = (ratio * 100).toStringAsFixed(0);
    final barColor = ratio < 0.8
        ? color
        : ratio < 1.0
            ? Colors.orange
            : AppTheme.expenseRed;

    return GestureDetector(
      onTap: onTap,
      child: Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.04), blurRadius: 6, offset: const Offset(0, 2))],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Text(emoji, style: const TextStyle(fontSize: 22)),
              const SizedBox(width: 10),
              Expanded(
                child: Text(label,
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
              ),
              if (over)
                const Icon(Icons.warning_amber_rounded, color: AppTheme.expenseRed, size: 16),
              const SizedBox(width: 4),
              RichText(
                text: TextSpan(
                  style: const TextStyle(fontSize: 13),
                  children: [
                    TextSpan(
                      text: '¥${spent.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: over ? AppTheme.expenseRed : AppTheme.textPrimary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(
                      text: ' / ¥${budget.toStringAsFixed(0)}',
                      style: const TextStyle(color: AppTheme.textSecondary),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: LayoutBuilder(builder: (ctx, constraints) {
                  return Stack(children: [
                    Container(
                      height: 6,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade200,
                          borderRadius: BorderRadius.circular(3)),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 400 + rowIndex * 80),
                      curve: Curves.easeOutCubic,
                      height: 6,
                      width: constraints.maxWidth * ratio,
                      decoration: BoxDecoration(
                          color: barColor, borderRadius: BorderRadius.circular(3)),
                    ),
                  ]);
                }),
              ),
              const SizedBox(width: 10),
              Text('$pct%',
                  style: TextStyle(
                      fontSize: 12,
                      color: barColor,
                      fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    ));
  }
}

// ── 未设预算时引导 ──────────────────────────────────────────────────
class _EmptyBudgetHint extends StatelessWidget {
  final VoidCallback onTap;
  const _EmptyBudgetHint({required this.onTap});

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 28),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: Colors.grey.shade200),
          ),
          child: Column(
            children: [
              const Text('💰', style: TextStyle(fontSize: 40)),
              const SizedBox(height: 10),
              const Text('还没有设置预算',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
              const SizedBox(height: 4),
              Text('点击设置各类别月度限额，超支时自动提醒',
                  style: TextStyle(color: Colors.grey.shade500, fontSize: 13)),
              const SizedBox(height: 14),
              ElevatedButton(
                onPressed: onTap,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: const Text('立即设置预算'),
              ),
            ],
          ),
        ),
      );
}

// ── 未设预算的有支出类别小提示 ─────────────────────────────────────
class _UnsetCategories extends StatelessWidget {
  final Map<String, double> expenses;
  final Map<String, double> budgets;
  final VoidCallback onTap;
  const _UnsetCategories({
    required this.expenses, required this.budgets, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final unset = AppConstants.expenseCategories
        .where((c) => (budgets[c.id] ?? 0) == 0 && (expenses[c.id] ?? 0) > 0)
        .toList();
    if (unset.isEmpty) return const SizedBox.shrink();
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.orange.shade50,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange.shade200),
        ),
        child: Row(
          children: [
            const Icon(Icons.lightbulb_outline, color: Colors.orange, size: 18),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                '${unset.map((c) => c.label).join('、')} 本月有支出，建议设置预算',
                style: const TextStyle(fontSize: 13, color: Colors.orange),
              ),
            ),
            const Icon(Icons.chevron_right, color: Colors.orange, size: 18),
          ],
        ),
      ),
    );
  }
}

