import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/bill_record.dart';
import '../../router/app_pages.dart';
import '../../widgets/animated_counter.dart';
import '../../widgets/coin_float_animation.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final bill = BillService.to;
    final ad = AdService.to;
    final statusBarH = MediaQuery.of(context).padding.top;

    return Stack(children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: Container(
          height: statusBarH + 56,
          decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
        ),
      ),
      Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Obx(() => Text(bill.currentMonthLabel,
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 17))),
          actions: [
            Obx(() => Padding(
                  padding: const EdgeInsets.only(right: 4),
                  child: Row(mainAxisSize: MainAxisSize.min, children: [
                    const Text('🪙', style: TextStyle(fontSize: 15)),
                    const SizedBox(width: 3),
                    Text('${ad.totalCoins.value}',
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14)),
                  ]),
                )),
            IconButton(
              icon: const Icon(Icons.chevron_left,
                  color: Colors.white, size: 22),
              onPressed: () => bill.changeMonth(-1),
            ),
            Obx(() => IconButton(
                  icon: Icon(Icons.chevron_right,
                      color: bill.isCurrentMonth
                          ? Colors.white30
                          : Colors.white,
                      size: 22),
                  onPressed:
                      bill.isCurrentMonth ? null : () => bill.changeMonth(1),
                )),
          ],
        ),
        body: Obx(() {
          final overBudget = bill.overBudgetCategories();
          final now = DateTime.now();
          final last3Bills = <BillRecord>[];
          for (int i = 1; i <= 3; i++) {
            final m = DateTime(now.year, now.month - i);
            last3Bills.addAll(StorageService.billsForMonth(m.year, m.month));
          }
          final insights = BillService.generateInsights(
            currentBills: bill.bills,
            monthlyExpense: bill.monthlyExpense.value,
            monthlyIncome: bill.monthlyIncome.value,
            last3MonthsBills: last3Bills,
            budgets: StorageService.budgets,
          );

          return ListView(
            padding: EdgeInsets.only(
                top: statusBarH + 56 + 16, bottom: 24, left: 0, right: 0),
            children: [
              if (overBudget.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                  child: _OverBudgetBanner(categories: overBudget),
                ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _MonthSummaryCard(
                  expense: bill.monthlyExpense.value,
                  income: bill.monthlyIncome.value,
                ),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _CalendarEntryCard(),
              ),
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _Top3Categories(
                    entries: bill.topExpenseCategories(3)),
              ),
              if (insights.isNotEmpty) ...[
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: _InsightsCard(insights: insights),
                ),
              ],
              const SizedBox(height: 14),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _QuickAddCard(
                    onTap: () => Get.toNamed(Routes.addBill)),
              ),
            ],
          );
        }),
      ),
      Obx(() => ad.showCoinAnimation.value
          ? CoinFloatAnimation(coins: ad.lastEarnedCoins.value)
          : const SizedBox.shrink()),
    ]);
  }
}

class _OverBudgetBanner extends StatelessWidget {
  final List<String> categories;
  const _OverBudgetBanner({required this.categories});

  @override
  Widget build(BuildContext context) {
    final labels = categories.map(BillService.categoryLabel).join('、');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.expenseRed.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.expenseRed.withValues(alpha: 0.4)),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        const Icon(Icons.warning_amber_rounded,
            color: AppTheme.expenseRed, size: 20),
        const SizedBox(width: 8),
        Expanded(
            child: Text('⚠️ $labels 已超出本月预算',
                style: const TextStyle(
                    color: AppTheme.expenseRed, fontSize: 13))),
      ]),
    );
  }
}

class _MonthSummaryCard extends StatelessWidget {
  final double expense;
  final double income;
  const _MonthSummaryCard({required this.expense, required this.income});

  @override
  Widget build(BuildContext context) {
    final net = income - expense;
    final total = expense + income;
    final hasData = total > 0;
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(20),
      child: Row(children: [
        SizedBox(
          width: 110, height: 110,
          child: Stack(alignment: Alignment.center, children: [
            PieChart(PieChartData(
              sectionsSpace: 3,
              centerSpaceRadius: 38,
              sections: hasData
                  ? [
                      PieChartSectionData(
                          value: expense,
                          color: AppTheme.expenseRed,
                          radius: 16,
                          title: ''),
                      PieChartSectionData(
                          value: income,
                          color: AppTheme.incomeGreen,
                          radius: 16,
                          title: ''),
                    ]
                  : [
                      PieChartSectionData(
                          value: 1,
                          color: Colors.grey.shade200,
                          radius: 16,
                          title: '')
                    ],
            )),
            Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                  net >= 0
                      ? '+${net.toStringAsFixed(0)}'
                      : net.toStringAsFixed(0),
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: net >= 0
                          ? AppTheme.incomeGreen
                          : AppTheme.expenseRed)),
              const Text('结余',
                  style: TextStyle(fontSize: 10, color: Colors.grey)),
            ]),
          ]),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AnimatedStatRow(
                  label: '支出',
                  value: expense,
                  color: AppTheme.expenseRed),
              const SizedBox(height: 12),
              _AnimatedStatRow(
                  label: '收入',
                  value: income,
                  color: AppTheme.incomeGreen),
              const SizedBox(height: 12),
              _AnimatedStatRow(
                  label: '结余',
                  value: net.abs(),
                  color: net >= 0
                      ? AppTheme.incomeGreen
                      : AppTheme.expenseRed),
            ],
          ),
        ),
      ]),
    );
  }
}

class _AnimatedStatRow extends StatelessWidget {
  final String label;
  final double value;
  final Color color;
  const _AnimatedStatRow(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label,
            style: const TextStyle(
                color: AppTheme.textSecondary, fontSize: 13)),
        AnimatedCounter(
          value: value,
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 15, color: color),
        ),
      ],
    );
  }
}

class _CalendarEntryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.calendar),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: AppTheme.gradientDecoration,
        child: const Row(children: [
          Icon(Icons.calendar_month_rounded, color: Colors.white, size: 28),
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('账单日历',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 15)),
                SizedBox(height: 2),
                Text('按日历查看每天收支明细',
                    style: TextStyle(color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
          Icon(Icons.chevron_right, color: Colors.white70),
        ]),
      ),
    );
  }
}

class _Top3Categories extends StatelessWidget {
  final List<MapEntry<String, double>> entries;
  const _Top3Categories({required this.entries});

  @override
  Widget build(BuildContext context) {
    if (entries.isEmpty) return const SizedBox.shrink();
    final maxVal = entries.first.value;
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('本月支出 Top', style: AppTheme.headline),
          const SizedBox(height: 12),
          ...entries.map((e) {
            final cat = AppConstants.categoryById(e.key);
            return Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: Row(children: [
                Text(cat.emoji, style: const TextStyle(fontSize: 20)),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(cat.label, style: AppTheme.body),
                          Text('¥${e.value.toStringAsFixed(2)}',
                              style: const TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.expenseRed)),
                        ],
                      ),
                      const SizedBox(height: 4),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: maxVal > 0 ? e.value / maxVal : 0,
                          minHeight: 6,
                          backgroundColor: Colors.grey.shade200,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(cat.color),
                        ),
                      ),
                    ],
                  ),
                ),
              ]),
            );
          }),
        ],
      ),
    );
  }
}

class _InsightsCard extends StatelessWidget {
  final List<String> insights;
  const _InsightsCard({required this.insights});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: AppTheme.cardDecoration,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(children: [
            const Icon(Icons.lightbulb_outline,
                color: AppTheme.warnOrange, size: 18),
            const SizedBox(width: 6),
            Text('本月洞察', style: AppTheme.headline),
          ]),
          const SizedBox(height: 12),
          ...insights.asMap().entries.map((e) => Padding(
                padding: EdgeInsets.only(
                    bottom: e.key < insights.length - 1 ? 8 : 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 5, height: 5,
                      margin: const EdgeInsets.only(top: 6, right: 8),
                      decoration: const BoxDecoration(
                          color: AppTheme.accent,
                          shape: BoxShape.circle),
                    ),
                    Expanded(child: Text(e.value, style: AppTheme.body)),
                  ],
                ),
              )),
        ],
      ),
    );
  }
}

class _QuickAddCard extends StatelessWidget {
  final VoidCallback onTap;
  const _QuickAddCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [AppTheme.primaryStart, AppTheme.primaryEnd],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Row(children: [
          Icon(Icons.add_circle_outline, color: Colors.white, size: 26),
          SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('记一笔',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15)),
            Text('快速记录今天的收支',
                style: TextStyle(color: Colors.white70, fontSize: 12)),
          ]),
          Spacer(),
          Icon(Icons.chevron_right, color: Colors.white70),
        ]),
      ),
    );
  }
}
