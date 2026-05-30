import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/models/bill_record.dart';
import '../constants/app_constants.dart';
import 'notification_service.dart';
import 'storage_service.dart';
import 'package:uuid/uuid.dart';

class BillService extends GetxService {
  static BillService get to => Get.find();

  static List<BillCategory> _customCatsCache = [];

  final RxList<BillRecord> bills       = <BillRecord>[].obs;
  final RxDouble monthlyExpense        = 0.0.obs;
  final RxDouble monthlyIncome         = 0.0.obs;
  final Rx<DateTime> currentMonth      = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    reloadCustomCategories();
    loadBills();
  }

  void loadBills() {
    final m = currentMonth.value;
    bills.value = StorageService.billsForMonth(m.year, m.month);
    _recalculate();
  }

  void changeMonth(int delta) {
    final m = currentMonth.value;
    currentMonth.value = DateTime(m.year, m.month + delta);
    loadBills();
  }

  void _recalculate() {
    monthlyExpense.value = bills
        .where((b) => b.isExpense)
        .fold(0.0, (sum, b) => sum + b.amount);
    monthlyIncome.value = bills
        .where((b) => !b.isExpense)
        .fold(0.0, (sum, b) => sum + b.amount);
  }

  Future<void> addBill({
    required double amount,
    required String type,
    required String category,
    required DateTime date,
    required String note,
  }) async {
    // 记账前先记录当前支出，用于判断是否刚越过预算阈值
    final prevSpent = expenseByCategory[category] ?? 0.0;

    final bill = BillRecord()
      ..id       = const Uuid().v4()
      ..amount   = amount
      ..type     = type
      ..category = category
      ..date     = date
      ..note     = note;
    await StorageService.saveBill(bill);
    loadBills();

    // 支出类账单：检测预算超限并推送通知
    if (type == 'expense') {
      final budget = StorageService.budgets[category] ?? 0.0;
      if (budget > 0) {
        final newSpent = expenseByCategory[category] ?? 0.0;
        await NotificationService.checkBudgetAlert(
          categoryId:    category,
          categoryLabel: categoryLabel(category),
          spent:         newSpent,
          budget:        budget,
          prevSpent:     prevSpent,
        );
      }
    }
  }

  Future<void> deleteBill(String id) async {
    await StorageService.deleteBill(id);
    loadBills();
  }

  // 按类别聚合支出（饼图用）
  Map<String, double> get expenseByCategory {
    final result = <String, double>{};
    for (final b in bills.where((b) => b.isExpense)) {
      result[b.category] = (result[b.category] ?? 0) + b.amount;
    }
    return result;
  }

  // 近6月收支对比（柱状图用）
  List<Map<String, double>> get last6MonthsStats {
    final now = DateTime.now();
    return List.generate(6, (i) {
      final m = DateTime(now.year, now.month - 5 + i);
      final monthBills = StorageService.billsForMonth(m.year, m.month);
      return {
        'expense': monthBills.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount),
        'income':  monthBills.where((b) => !b.isExpense).fold(0.0, (s, b) => s + b.amount),
      };
    });
  }

  // 本月各类别支出（预算对比用）
  Map<String, double> get currentMonthExpenseByCategory => expenseByCategory;

  // 超预算类别
  List<String> overBudgetCategories() {
    final budgets = StorageService.budgets;
    final expenses = expenseByCategory;
    return budgets.keys
        .where((k) => (expenses[k] ?? 0) > (budgets[k] ?? double.infinity))
        .toList();
  }

  // Top N 支出类别
  List<MapEntry<String, double>> topExpenseCategories(int n) {
    final sorted = expenseByCategory.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sorted.take(n).toList();
  }

  // 按日期分组（账单列表用）
  Map<String, List<BillRecord>> get billsByDate {
    final result = <String, List<BillRecord>>{};
    final now = DateTime.now();
    for (final b in bills) {
      String key;
      if (b.date.year == now.year && b.date.month == now.month && b.date.day == now.day) {
        key = '今天';
      } else if (b.date.year == now.year &&
                 b.date.month == now.month &&
                 b.date.day == now.day - 1) {
        key = '昨天';
      } else {
        key = '${b.date.year}-${b.date.month.toString().padLeft(2, '0')}-${b.date.day.toString().padLeft(2, '0')}';
      }
      result.putIfAbsent(key, () => []).add(b);
    }
    return result;
  }

  String get currentMonthLabel {
    final m = currentMonth.value;
    return '${m.year}年${m.month}月';
  }

  bool get isCurrentMonth {
    final m = currentMonth.value;
    final now = DateTime.now();
    return m.year == now.year && m.month == now.month;
  }

  void reloadCustomCategories() {
    _customCatsCache = StorageService.customCategories
        .map<BillCategory>((m) => BillCategory(
              id: m['id'] as String,
              label: m['name'] as String,
              emoji: m['emoji'] as String,
              color: const Color(0xFF6C5CE7),
              isExpense: (m['isExpense'] as bool?) ?? true,
            ))
        .toList();
  }

  static String categoryLabel(String id) {
    final builtins = AppConstants.allCategories.where((c) => c.id == id);
    if (builtins.isNotEmpty) return builtins.first.label;
    final customs = _customCatsCache.where((c) => c.id == id);
    if (customs.isNotEmpty) return customs.first.label;
    return '其他';
  }

  static String categoryEmoji(String id) {
    final builtins = AppConstants.allCategories.where((c) => c.id == id);
    if (builtins.isNotEmpty) return builtins.first.emoji;
    final customs = _customCatsCache.where((c) => c.id == id);
    if (customs.isNotEmpty) return customs.first.emoji;
    return '💡';
  }

  static List<String> generateInsights({
    required List<BillRecord> currentBills,
    required double monthlyExpense,
    required double monthlyIncome,
    required List<BillRecord> last3MonthsBills,
    required Map<String, double> budgets,
  }) {
    final now = DateTime.now();
    final insights = <String>[];

    // Rule 1: 某分类本月 > 过去3个完整自然月均值 × 1.3
    final currentByCategory = <String, double>{};
    for (final b in currentBills.where((b) => b.isExpense)) {
      currentByCategory[b.category] =
          (currentByCategory[b.category] ?? 0) + b.amount;
    }
    final last3ByCategory = <String, List<double>>{};
    for (int i = 1; i <= 3; i++) {
      final m = DateTime(now.year, now.month - i);
      final monthMap = <String, double>{};
      for (final b in last3MonthsBills.where((b) =>
          b.isExpense && b.date.year == m.year && b.date.month == m.month)) {
        monthMap[b.category] = (monthMap[b.category] ?? 0) + b.amount;
      }
      for (final e in monthMap.entries) {
        last3ByCategory.putIfAbsent(e.key, () => []).add(e.value);
      }
    }
    for (final e in currentByCategory.entries) {
      final hist = last3ByCategory[e.key];
      if (hist != null && hist.isNotEmpty) {
        final avg = hist.reduce((a, b) => a + b) / hist.length;
        if (avg > 0 && e.value > avg * 1.3) {
          final pct = ((e.value - avg) / avg * 100).round();
          insights.add('${categoryLabel(e.key)}支出比近3月均值高 $pct%，注意控制');
        }
      }
    }

    // Rule 2/3: 收支比
    if (monthlyIncome > 0) {
      final ratio = monthlyExpense / monthlyIncome;
      if (ratio < 0.7) {
        final sr = ((1 - ratio) * 100).round();
        insights.add('本月储蓄率 $sr%，财务状况健康 👍');
      } else if (ratio > 0.9) {
        insights.add('本月支出已达收入的 ${(ratio * 100).round()}%，建议减少非必要消费');
      }
    }

    // Rule 4: 连续零支出天数
    final today = DateTime(now.year, now.month, now.day);
    int streak = 0;
    for (int i = 0; i < 30; i++) {
      final day = today.subtract(Duration(days: i));
      final hasExp = currentBills.any((b) =>
          b.isExpense &&
          b.date.year == day.year &&
          b.date.month == day.month &&
          b.date.day == day.day);
      if (!hasExp) {
        streak++;
      } else {
        break;
      }
    }
    if (streak >= 3) {
      insights.add('已连续 $streak 天零支出，坚持得很好！');
    }

    // Rule 5: 月末超预算提醒（日期 > 25）
    if (now.day > 25) {
      final overCats = budgets.keys
          .where((k) =>
              (currentByCategory[k] ?? 0) > (budgets[k] ?? double.infinity))
          .map(categoryLabel)
          .toList();
      if (overCats.isNotEmpty) {
        final remaining = DateTime(now.year, now.month + 1, 0).day - now.day;
        insights.add('月末剩 $remaining 天，${overCats.join('、')} 已超预算');
      }
    }

    // 优先告警，最多返回 3 条
    final warnings = insights.where(
        (s) => s.contains('注意') || s.contains('建议') || s.contains('超预算')).toList();
    final positive = insights
        .where((s) => s.contains('👍') || s.contains('坚持'))
        .toList();
    return [...warnings, ...positive].take(3).toList();
  }
}
