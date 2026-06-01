// lib/modules/report/category_drill_view.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/bill_record.dart';

class CategoryDrillView extends StatelessWidget {
  const CategoryDrillView({super.key});

  @override
  Widget build(BuildContext context) {
    final categoryId = Get.arguments as String;
    final cat = [
      ...AppConstants.expenseCategories,
      ...AppConstants.incomeCategories,
    ].firstWhere((c) => c.id == categoryId, orElse: () => AppConstants.expenseCategories.first);

    final now   = DateTime.now();
    final months = List.generate(6, (i) {
      final m = DateTime(now.year, now.month - 5 + i, 1);
      return m;
    });
    final monthTotals = months.map((m) {
      final bills = StorageService.billsForMonth(m.year, m.month)
          .where((b) => b.category == categoryId && b.isExpense);
      return bills.fold(0.0, (s, b) => s + b.amount);
    }).toList();

    final allBills = StorageService.allBills
        .where((b) => b.category == categoryId)
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.primaryStart,
        title: Text('${cat.emoji} ${cat.label}', style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView(padding: const EdgeInsets.fromLTRB(16, 20, 16, 32), children: [
        // 近6个月趋势
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text('近 6 个月趋势', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 16),
            SizedBox(
              height: 140,
              child: LineChart(LineChartData(
                gridData: FlGridData(
                  show: true,
                  getDrawingHorizontalLine: (_) => FlLine(color: Colors.grey.shade100, strokeWidth: 1),
                  drawVerticalLine: false,
                ),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  bottomTitles: AxisTitles(sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (v, _) {
                      final idx = v.toInt();
                      if (idx < 0 || idx >= months.length) return const SizedBox.shrink();
                      return Text(DateFormat('M月').format(months[idx]),
                          style: const TextStyle(fontSize: 10, color: AppTheme.textSecondary));
                    },
                    interval: 1,
                  )),
                ),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: List.generate(6, (i) => FlSpot(i.toDouble(), monthTotals[i])),
                    isCurved: true,
                    color: AppTheme.primaryStart,
                    barWidth: 2.5,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppTheme.primaryStart.withValues(alpha: 0.08),
                    ),
                  ),
                ],
              )),
            ),
          ]),
        ),
        const SizedBox(height: 16),

        // 全部账单列表
        Container(
          padding: const EdgeInsets.all(16),
          decoration: AppTheme.cardDecoration,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('全部账单（${allBills.length} 条）',
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
            const SizedBox(height: 12),
            if (allBills.isEmpty)
              Center(child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text('暂无账单', style: AppTheme.caption),
              ))
            else
              ...allBills.map((b) => _BillRow(bill: b)),
          ]),
        ),
      ]),
    );
  }
}

class _BillRow extends StatelessWidget {
  final BillRecord bill;
  const _BillRow({required this.bill});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 8),
    child: Row(children: [
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(bill.note.isEmpty ? '无备注' : bill.note,
            style: const TextStyle(fontSize: 14)),
        Text(DateFormat('yyyy年MM月dd日').format(bill.date), style: AppTheme.caption),
      ])),
      Text(
        '${bill.isExpense ? '-' : '+'}¥${bill.amount.toStringAsFixed(2)}',
        style: TextStyle(
          fontSize: 14, fontWeight: FontWeight.w600,
          color: bill.isExpense ? AppTheme.expenseRed : AppTheme.incomeGreen,
        ),
      ),
    ]),
  );
}
