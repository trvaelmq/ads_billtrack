import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/bill_service.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';
import '../../widgets/coin_float_animation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = BillService.to;
    final ad   = AdService.to;
    return Stack(
      children: [
        Scaffold(
          appBar: AppBar(
            title: Obx(() => Text(bill.currentMonthLabel)),
            actions: [
              Obx(() => Padding(
                    padding: const EdgeInsets.only(right: 16),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('🪙', style: TextStyle(fontSize: 16)),
                        const SizedBox(width: 4),
                        Text(
                          '${ad.totalCoins.value}',
                          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                      ],
                    ),
                  )),
              // 切换月份
              IconButton(
                icon: const Icon(Icons.chevron_left, color: Colors.white),
                onPressed: () => bill.changeMonth(-1),
              ),
              IconButton(
                icon: const Icon(Icons.chevron_right, color: Colors.white),
                onPressed: () => bill.isCurrentMonth ? null : bill.changeMonth(1),
              ),
            ],
          ),
          body: Obx(() {
            final overBudget = bill.overBudgetCategories();
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // 超预算警告
                if (overBudget.isNotEmpty) _OverBudgetBanner(categories: overBudget),
                if (overBudget.isNotEmpty) const SizedBox(height: 12),
                // 月度收支 Ring Chart
                _MonthSummaryCard(
                  expense: bill.monthlyExpense.value,
                  income:  bill.monthlyIncome.value,
                ),
                const SizedBox(height: 16),
                // Top3 支出类别
                _Top3Categories(entries: bill.topExpenseCategories(3)),
                const SizedBox(height: 16),
                // 快捷记账
                _QuickAddCard(onTap: () => Get.toNamed(Routes.addBill)),
                const SizedBox(height: 16), 
              ],
            );
          }),
        ),
        // 金币上飘动画
        Obx(() => ad.showCoinAnimation.value
            ? CoinFloatAnimation(coins: ad.lastEarnedCoins.value)
            : const SizedBox.shrink()),
      ],
    );
  }
}

// ── 超预算警告 ──────────────────────────────────────────────────────
class _OverBudgetBanner extends StatelessWidget {
  final List<String> categories;
  const _OverBudgetBanner({required this.categories});

  @override
  Widget build(BuildContext context) {
    final labels = categories
        .map((id) => BillService.categoryLabel(id))
        .join('、');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.expenseRed.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.expenseRed.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppTheme.expenseRed, size: 20),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              '⚠️ $labels 已超出本月预算',
              style: const TextStyle(color: AppTheme.expenseRed, fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

// ── 月度收支 Ring Chart ────────────────────────────────────────────
class _MonthSummaryCard extends StatelessWidget {
  final double expense;
  final double income;
  const _MonthSummaryCard({required this.expense, required this.income});

  @override
  Widget build(BuildContext context) {
    final net    = income - expense;
    final total  = expense + income;
    final hasData = total > 0;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            SizedBox(
              width: 110, height: 110,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  PieChart(PieChartData(
                    sectionsSpace: 3,
                    centerSpaceRadius: 38,
                    sections: hasData
                        ? [
                            PieChartSectionData(value: expense, color: AppTheme.expenseRed, radius: 16, title: ''),
                            PieChartSectionData(value: income,  color: AppTheme.incomeGreen, radius: 16, title: ''),
                          ]
                        : [PieChartSectionData(value: 1, color: Colors.grey.shade200, radius: 16, title: '')],
                  )),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(net >= 0 ? '+${net.toStringAsFixed(0)}' : net.toStringAsFixed(0),
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: net >= 0 ? AppTheme.incomeGreen : AppTheme.expenseRed)),
                      const Text('结余', style: TextStyle(fontSize: 10, color: Colors.grey)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _StatRow(label: '支出', value: expense, color: AppTheme.expenseRed),
                  const SizedBox(height: 12),
                  _StatRow(label: '收入', value: income, color: AppTheme.incomeGreen),
                  const SizedBox(height: 12),
                  _StatRow(label: '结余', value: net, color: net >= 0 ? AppTheme.incomeGreen : AppTheme.expenseRed),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final double value;
  final Color  color;
  const _StatRow({required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: const TextStyle(color: AppTheme.textSecondary, fontSize: 13)),
        Text(
          '¥${value.abs().toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color),
        ),
      ],
    );
  }
}

// ── Top3 支出类别 ─────────────────────────────────────────────────
class _Top3Categories extends StatelessWidget {
  final List<MapEntry<String, double>> entries;
  const _Top3Categories({required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();
    final max = entries.first.value;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('本月支出 Top', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            ...entries.map((e) {
              final cat = AppConstants.categoryById(e.key);
              return Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Row(
                  children: [
                    Text(cat.emoji, style: const TextStyle(fontSize: 20)),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(cat.label, style: const TextStyle(fontSize: 13)),
                              Text('¥${e.value.toStringAsFixed(2)}',
                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppTheme.expenseRed)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(4),
                            child: LinearProgressIndicator(
                              value: max > 0 ? e.value / max : 0,
                              minHeight: 6,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: AlwaysStoppedAnimation<Color>(cat.color),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

// ── 快捷记账 ──────────────────────────────────────────────────────
class _QuickAddCard extends StatelessWidget {
  final VoidCallback onTap;
  const _QuickAddCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primary, AppTheme.secondary],
            begin: Alignment.topLeft, end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(
          children: [
            Icon(Icons.add_circle_outline, color: Colors.white, size: 28),
            SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('记一笔', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
                Text('快速记录今天的收支', style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
            Spacer(),
            Icon(Icons.chevron_right, color: Colors.white70),
          ],
        ),
      ),
    );
  }
}
