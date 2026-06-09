import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
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

  /// 按范围筛选账单（纯函数，可单测）
  static List<BillRecord> filterByRange(
    List<BillRecord> all, {DateTime? month, int? year, bool allTime = false}) {
    if (allTime) return all;
    if (year != null) return all.where((b) => b.date.year == year).toList();
    if (month != null) {
      return all.where((b) =>
          b.date.year == month.year && b.date.month == month.month).toList();
    }
    return all;
  }

  // 导出账单为 CSV 并分享
  Future<void> exportBillsAsCsv({bool allTime = false}) async {
    final records = allTime
        ? StorageService.allBills
        : StorageService.billsForMonth(currentMonth.value.year, currentMonth.value.month);

    if (records.isEmpty) {
      Get.snackbar('提示', '暂无账单数据可导出', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    final buf = StringBuffer();
    buf.writeln('日期,类型,金额,分类,备注');
    for (final b in records) {
      final date = DateFormat('yyyy-MM-dd').format(b.date);
      final type = b.isExpense ? '支出' : '收入';
      final amount = b.amount.toStringAsFixed(2);
      final cat = categoryLabel(b.category);
      final note = b.note.replaceAll(',', '，');
      buf.writeln('$date,$type,$amount,$cat,$note');
    }

    final dir = await getTemporaryDirectory();
    final label = allTime ? '全部账单' : '${currentMonth.value.year}年${currentMonth.value.month}月账单';
    final file = File('${dir.path}/$label.csv');
    await file.writeAsString(buf.toString(), flush: true);

    await Share.shareXFiles([XFile(file.path)], text: '$label 导出');
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

  /// 生成上月总结（用于月度总结卡片）
  static Map<String, dynamic>? buildMonthlySummary() {
    final now  = DateTime.now();
    final prev = DateTime(now.year, now.month - 1, 1);
    final prevBills = StorageService.billsForMonth(prev.year, prev.month);
    if (prevBills.isEmpty) return null;

    final expense = prevBills.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount);
    final income  = prevBills.where((b) => !b.isExpense).fold(0.0, (s, b) => s + b.amount);

    final catMap = <String, double>{};
    for (final b in prevBills.where((b) => b.isExpense)) {
      catMap[b.category] = (catMap[b.category] ?? 0) + b.amount;
    }
    final topCat = catMap.isEmpty ? null :
        catMap.entries.reduce((a, b) => a.value > b.value ? a : b).key;

    final budgets = StorageService.budgets;
    double budgetExecRate = -1;
    if (budgets.isNotEmpty) {
      final total  = budgets.values.fold(0.0, (s, v) => s + v);
      budgetExecRate = total > 0 ? (expense / total).clamp(0.0, 2.0) : -1;
    }

    final history = StorageService.scoreHistory;
    final curHist  = history.where((h) => h.year == prev.year && h.month == prev.month).firstOrNull;
    final prevHist = history.where((h) {
      final pm = DateTime(prev.year, prev.month - 1, 1);
      return h.year == pm.year && h.month == pm.month;
    }).firstOrNull;
    final scoreDiff = (curHist != null && prevHist != null)
        ? curHist.total - prevHist.total : null;

    String summary;
    if (expense == 0) {
      summary = '上月无支出记录，建议保持记账习惯';
    } else if (income > 0 && expense < income * 0.5) {
      summary = '上月储蓄率优秀，继续保持！';
    } else if (budgetExecRate > 1.0) {
      summary = '上月总支出超出预算，本月注意控制';
    } else {
      summary = '上月收支整体良好，继续加油！';
    }

    return {
      'month': '${prev.year}年${prev.month}月',
      'expense': expense,
      'income': income,
      'topCat': topCat,
      'budgetExecRate': budgetExecRate,
      'scoreDiff': scoreDiff,
      'summary': summary,
    };
  }

  /// 升级版异常检测：区分偶发大额和持续超支
  static List<String> generateUpgradedInsights({
    required List<BillRecord> currentBills,
    required double monthlyExpense,
  }) {
    final insights = <String>[];
    final now = DateTime.now();
    final budgets = StorageService.budgets;

    final catMap = <String, double>{};
    for (final b in currentBills.where((b) => b.isExpense)) {
      catMap[b.category] = (catMap[b.category] ?? 0) + b.amount;
    }

    final avg3 = <String, double>{};
    for (var i = 1; i <= 3; i++) {
      final m = DateTime(now.year, now.month - i, 1);
      final mb = StorageService.billsForMonth(m.year, m.month);
      for (final b in mb.where((b) => b.isExpense)) {
        avg3[b.category] = (avg3[b.category] ?? 0) + b.amount / 3;
      }
    }

    final categoryBills = <String, List<BillRecord>>{};
    for (final b in currentBills.where((b) => b.isExpense)) {
      categoryBills.putIfAbsent(b.category, () => []).add(b);
    }
    for (final entry in categoryBills.entries) {
      final catAvg = avg3[entry.key] ?? 0;
      if (catAvg <= 0) continue;
      final maxBill = entry.value.map((b) => b.amount).reduce((a, b) => a > b ? a : b);
      if (maxBill > catAvg * 2) {
        final label = categoryLabel(entry.key);
        insights.add('「$label」单笔消费偏高（¥${maxBill.toStringAsFixed(0)}），注意是否为必要支出');
      }
    }

    if (now.day <= 15) {
      for (final entry in budgets.entries) {
        final spent  = catMap[entry.key] ?? 0;
        final budget = entry.value;
        if (budget > 0 && spent > budget * 0.8) {
          final label = categoryLabel(entry.key);
          insights.add('「$label」本月支出节奏偏快，月中已用 ${(spent / budget * 100).toStringAsFixed(0)}% 预算');
        }
      }
    }

    return insights.take(2).toList();
  }
}
