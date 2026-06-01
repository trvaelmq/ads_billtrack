// lib/modules/report/compare_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';

class CompareView extends StatelessWidget {
  const CompareView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      final bill  = BillService.to;
      final cur   = bill.currentMonth.value;
      final prev  = DateTime(cur.year, cur.month - 1, 1);
      final yago  = DateTime(cur.year - 1, cur.month, 1);

      final curBills  = StorageService.billsForMonth(cur.year,  cur.month);
      final prevBills = StorageService.billsForMonth(prev.year, prev.month);
      final yagoBills = StorageService.billsForMonth(yago.year, yago.month);

      Map<String, double> catTotal(List<dynamic> bills) {
        final map = <String, double>{};
        for (final b in bills) {
          if (b.isExpense) map[b.category] = (map[b.category] ?? 0) + b.amount;
        }
        return map;
      }

      final curMap  = catTotal(curBills);
      final prevMap = catTotal(prevBills);
      final yagoMap = catTotal(yagoBills);

      final cats = AppConstants.expenseCategories
          .where((c) => (curMap[c.id] ?? 0) + (prevMap[c.id] ?? 0) + (yagoMap[c.id] ?? 0) > 0)
          .toList();

      return ListView(padding: const EdgeInsets.fromLTRB(16, 16, 16, 32), children: [
        // 表头
        Row(children: [
          const Expanded(flex: 2, child: SizedBox.shrink()),
          Expanded(child: Text(DateFormat('M月').format(cur), textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
          Expanded(child: Text(DateFormat('M月').format(prev), textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
          Expanded(child: Text('去年${DateFormat('M月').format(yago)}', textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary))),
        ]),
        const SizedBox(height: 8),
        // 总计行
        _CompareRow(
          label: '总支出', emoji: '💰',
          cur: curBills.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount),
          prev: prevBills.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount),
          yago: yagoBills.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount),
          isHeader: true,
        ),
        const Divider(height: 24),
        // 各分类行
        ...cats.map((c) => _CompareRow(
          label: c.label, emoji: c.emoji,
          cur:  curMap[c.id]  ?? 0,
          prev: prevMap[c.id] ?? 0,
          yago: yagoMap[c.id] ?? 0,
        )),
      ]);
    });
  }
}

class _CompareRow extends StatelessWidget {
  final String label, emoji;
  final double cur, prev, yago;
  final bool isHeader;
  const _CompareRow({
    required this.label, required this.emoji,
    required this.cur, required this.prev, required this.yago,
    this.isHeader = false,
  });

  Widget _trend(double a, double b) {
    if (b == 0) return const SizedBox(width: 14);
    final up = a > b;
    return Icon(
      up ? Icons.arrow_upward : Icons.arrow_downward,
      size: 12,
      color: up ? AppTheme.expenseRed : AppTheme.incomeGreen,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(children: [
        Expanded(flex: 2, child: Row(children: [
          Text(emoji, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(
            fontSize: isHeader ? 14 : 13,
            fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
          )),
        ])),
        Expanded(child: Text(
          cur > 0 ? '¥${cur.toStringAsFixed(0)}' : '-',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, fontWeight: isHeader ? FontWeight.bold : FontWeight.normal),
        )),
        Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(prev > 0 ? '¥${prev.toStringAsFixed(0)}' : '-',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          _trend(cur, prev),
        ])),
        Expanded(child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(yago > 0 ? '¥${yago.toStringAsFixed(0)}' : '-',
              style: TextStyle(fontSize: 12, color: AppTheme.textSecondary)),
          _trend(cur, yago),
        ])),
      ]),
    );
  }
}
