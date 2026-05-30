import 'package:get/get.dart';
import '../../data/models/bill_record.dart';
import '../constants/app_constants.dart';
import 'notification_service.dart';
import 'storage_service.dart';
import 'package:uuid/uuid.dart';

class BillService extends GetxService {
  static BillService get to => Get.find();

  final RxList<BillRecord> bills       = <BillRecord>[].obs;
  final RxDouble monthlyExpense        = 0.0.obs;
  final RxDouble monthlyIncome         = 0.0.obs;
  final Rx<DateTime> currentMonth      = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
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

  // 获取账单分类名
  static String categoryLabel(String id) => AppConstants.categoryById(id).label;
  static String categoryEmoji(String id) => AppConstants.categoryById(id).emoji;
}
