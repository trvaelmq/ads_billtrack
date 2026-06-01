// lib/modules/report/heatmap_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../core/services/storage_service.dart';
import '../../core/theme/app_theme.dart';
import '../../router/app_pages.dart';

// 不带 Scaffold，直接作为 TabBarView 子 Widget 使用
class HeatmapView extends StatefulWidget {
  const HeatmapView({super.key});
  @override
  State<HeatmapView> createState() => _HeatmapViewState();
}

class _HeatmapViewState extends State<HeatmapView> {
  int _year = DateTime.now().year;

  Map<DateTime, double> _buildDayMap() {
    final map = <DateTime, double>{};
    for (final bill in StorageService.allBills) {
      if (bill.date.year != _year || !bill.isExpense) continue;
      final key = DateTime(bill.date.year, bill.date.month, bill.date.day);
      map[key] = (map[key] ?? 0) + bill.amount;
    }
    return map;
  }

  Color _cellColor(double? amount) {
    if (amount == null || amount == 0) return Colors.grey.shade100;
    if (amount < 50)  return AppTheme.primaryEnd.withValues(alpha: 0.3);
    if (amount < 200) return AppTheme.primaryEnd.withValues(alpha: 0.6);
    if (amount < 500) return AppTheme.primaryStart.withValues(alpha: 0.8);
    return AppTheme.primaryStart;
  }

  @override
  Widget build(BuildContext context) {
    final dayMap = _buildDayMap();
    final jan1 = DateTime(_year, 1, 1);
    final startOffset = (jan1.weekday - 1);
    final totalDays   = DateTime(_year + 1, 1, 1).difference(jan1).inDays;
    final totalCells  = startOffset + totalDays;
    final weeks       = (totalCells / 7).ceil();

    return Padding(
        padding: const EdgeInsets.all(16),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // 年份选择行
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            IconButton(
              icon: const Icon(Icons.chevron_left),
              onPressed: () => setState(() => _year--),
            ),
            Text('$_year 年', style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            IconButton(
              icon: Icon(Icons.chevron_right,
                  color: _year >= DateTime.now().year ? Colors.grey.shade300 : null),
              onPressed: _year >= DateTime.now().year ? null : () => setState(() => _year++),
            ),
          ]),
          const SizedBox(height: 4),
          // 图例
          Row(children: [
            Text('少', style: AppTheme.caption),
            const SizedBox(width: 6),
            ...[ Colors.grey.shade100,
                 AppTheme.primaryEnd.withValues(alpha: 0.3),
                 AppTheme.primaryEnd.withValues(alpha: 0.6),
                 AppTheme.primaryStart.withValues(alpha: 0.8),
                 AppTheme.primaryStart,
            ].map((c) => Container(
              width: 14, height: 14, margin: const EdgeInsets.only(right: 3),
              decoration: BoxDecoration(color: c, borderRadius: BorderRadius.circular(3)),
            )),
            const SizedBox(width: 6),
            Text('多', style: AppTheme.caption),
          ]),
          const SizedBox(height: 12),
          // 格子
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(weeks, (w) {
                  return Column(children: List.generate(7, (d) {
                    final dayIndex = w * 7 + d - startOffset;
                    if (dayIndex < 0 || dayIndex >= totalDays) {
                      return const SizedBox(width: 14, height: 14, child: SizedBox.shrink());
                    }
                    final date = jan1.add(Duration(days: dayIndex));
                    final amount = dayMap[date];
                    return GestureDetector(
                      onTap: amount != null && amount > 0
                          ? () => Get.toNamed(Routes.dayDetail, arguments: date)
                          : null,
                      child: Tooltip(
                        message: amount != null && amount > 0
                            ? '${DateFormat('MM/dd').format(date)}  ¥${amount.toStringAsFixed(0)}'
                            : '',
                        child: Container(
                          width: 13, height: 13,
                          margin: const EdgeInsets.all(1),
                          decoration: BoxDecoration(
                            color: _cellColor(amount),
                            borderRadius: BorderRadius.circular(2),
                          ),
                        ),
                      ),
                    );
                  }));
                }),
              ),
            ),
          ),
          const SizedBox(height: 12),
          // 统计汇总
          Builder(builder: (_) {
            final total = dayMap.values.fold(0.0, (a, b) => a + b);
            final days  = dayMap.values.where((v) => v > 0).length;
            return Row(children: [
              _StatChip(label: '全年支出', value: '¥${total.toStringAsFixed(0)}'),
              const SizedBox(width: 12),
              _StatChip(label: '记账天数', value: '$days 天'),
              const SizedBox(width: 12),
              if (days > 0)
                _StatChip(label: '日均支出', value: '¥${(total / days).toStringAsFixed(0)}'),
            ]);
          }),
        ]),
      );
  }
}

class _StatChip extends StatelessWidget {
  final String label, value;
  const _StatChip({required this.label, required this.value});
  @override
  Widget build(BuildContext context) => Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
    Text(label, style: AppTheme.caption),
    Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppTheme.textPrimary)),
  ]);
}
