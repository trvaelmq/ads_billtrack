import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/recurring_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/bill_record.dart';
import '../../data/models/recurring_rule.dart';
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
      Scaffold(
        extendBodyBehindAppBar: true,
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.addBill),
          backgroundColor: AppTheme.accent,
          child: const Icon(Icons.add, color: Colors.white),
        ),
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

          return Column(children: [
            Container(
              height: statusBarH + 56,
              decoration: const BoxDecoration(gradient: AppTheme.primaryGradient),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(top: 16, bottom: 24),
                children: [
                  // 到期账单提醒 Banner
                  Obx(() {
                    final dueRules = RecurringService.to.dueRules;
                    if (dueRules.isEmpty) return const SizedBox.shrink();
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
                      child: Column(
                        children: dueRules.map((rule) => _DueBanner(rule: rule)).toList(),
                      ),
                    );
                  }),
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
                    child: _HealthScoreCard(
                      expense: bill.monthlyExpense.value,
                      income: bill.monthlyIncome.value,
                    ),
                  ),
                  const SizedBox(height: 14),
                  _BillSection(bill: bill, context: context),
                  const SizedBox(height: 80),
                ],
              ),
            ),
          ]);
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

// ── Bill Section ──────────────────────────────────────────────────────────────

class _BillSection extends StatelessWidget {
  final BillService bill;
  final BuildContext context;
  const _BillSection({required this.bill, required this.context});

  @override
  Widget build(BuildContext ctx) {
    final grouped = bill.billsByDate;
    if (grouped.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: AppTheme.cardDecoration,
          child: const Center(
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text('💸', style: TextStyle(fontSize: 40)),
              SizedBox(height: 8),
              Text('本月还没有账单', style: TextStyle(color: AppTheme.textSecondary, fontSize: 14)),
              SizedBox(height: 4),
              Text('点击右下角 + 记录第一笔', style: TextStyle(color: Colors.grey, fontSize: 12)),
            ]),
          ),
        ),
      );
    }

    final keys = grouped.keys.toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Row(children: [
            Text('本月账单', style: AppTheme.headline),
            const Spacer(),
            Text('${bill.bills.length} 笔',
                style: const TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          ]),
        ),
        ...keys.map((dateKey) {
          final items      = grouped[dateKey]!;
          final dayExpense = items.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount);
          final dayIncome  = items.where((b) => !b.isExpense).fold(0.0, (s, b) => s + b.amount);
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 16),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Row(children: [
                  Text(dateKey,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12, color: AppTheme.textSecondary)),
                  const Spacer(),
                  if (dayExpense > 0)
                    Text('支出 ¥${dayExpense.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 11, color: AppTheme.expenseRed)),
                  if (dayExpense > 0 && dayIncome > 0)
                    const SizedBox(width: 8),
                  if (dayIncome > 0)
                    Text('收入 ¥${dayIncome.toStringAsFixed(2)}',
                        style: const TextStyle(fontSize: 11, color: AppTheme.incomeGreen)),
                ]),
              ),
              ...items.map((b) => _HomeBillItem(
                record: b,
                onDelete: () => _confirmDelete(ctx, b, bill),
              )),
            ],
          );
        }),
      ],
    );
  }

  void _confirmDelete(BuildContext ctx, BillRecord b, BillService bill) {
    showDialog(
      context: ctx,
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

class _HomeBillItem extends StatelessWidget {
  final BillRecord record;
  final VoidCallback onDelete;
  const _HomeBillItem({required this.record, required this.onDelete});

  @override
  Widget build(BuildContext context) {
    final cat = AppConstants.categoryById(record.category);
    return GestureDetector(
      onLongPress: onDelete,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 3),
        decoration: AppTheme.cardDecoration,
        child: ListTile(
          leading: Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
                color: cat.color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12)),
            child: Center(child: Text(cat.emoji, style: const TextStyle(fontSize: 22))),
          ),
          title: Text(cat.label,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
          subtitle: record.note.isNotEmpty
              ? Text(record.note,
                  style: const TextStyle(fontSize: 12, color: Colors.grey), maxLines: 1)
              : Text(DateFormat('HH:mm').format(record.date),
                  style: const TextStyle(fontSize: 12, color: Colors.grey)),
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

// ── Due Bill Banner ───────────────────────────────────────────────────────────

class _DueBanner extends StatelessWidget {
  final RecurringRule rule;
  const _DueBanner({required this.rule});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppTheme.warnOrange.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.warnOrange.withValues(alpha: 0.4)),
      ),
      child: Row(children: [
        const Text('🔔', style: TextStyle(fontSize: 18)),
        const SizedBox(width: 10),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('「${rule.title}」今日到期', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
          Text('¥${rule.amount.toStringAsFixed(0)}  ${rule.isExpense ? '支出' : '收入'}',
              style: AppTheme.caption),
        ])),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppTheme.warnOrange,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: () async {
            await RecurringService.to.recordDue(rule);
            Get.snackbar('已记录', '「${rule.title}」已记录到本月账单', snackPosition: SnackPosition.BOTTOM);
          },
          child: const Text('一键记录', style: TextStyle(fontSize: 12)),
        ),
      ]),
    );
  }
}

// ── Health Score Preview Card ─────────────────────────────────────────────────

class _HealthScoreCard extends StatelessWidget {
  final double income;
  final double expense;
  const _HealthScoreCard({required this.income, required this.expense});

  int get _quickScore {
    if (income == 0 && expense == 0) return 60;
    if (income == 0) return 30;
    final rate = (income - expense) / income;
    return (rate.clamp(-0.5, 1.0) * 70 + 30).round().clamp(0, 100);
  }

  Color get _scoreColor {
    final s = _quickScore;
    if (s >= 85) return AppTheme.incomeGreen;
    if (s >= 70) return const Color(0xFF00B4D8);
    if (s >= 50) return AppTheme.warnOrange;
    return AppTheme.expenseRed;
  }

  @override
  Widget build(BuildContext context) {
    final score = _quickScore;
    final color = _scoreColor;
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.healthScore),
      child: Container(
        decoration: AppTheme.cardDecoration,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text('$score',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: color)),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Text('财务健康评分', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600)),
              const SizedBox(height: 2),
              Text('查看本月财务健康详细分析', style: AppTheme.caption),
            ]),
          ),
          const Icon(Icons.chevron_right, color: Colors.grey),
        ]),
      ),
    );
  }
}
