import 'package:get/get.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/storage_service.dart';
import '../../router/app_pages.dart';

class ReportController extends GetxController {
  final bill = BillService.to;
  final budgets = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    _loadBudgets();
  }

  void _loadBudgets() {
    budgets.value = Map.from(StorageService.budgets);
  }

  void refreshBudgets() => _loadBudgets();

  double get lastMonthExpense {
    final m = bill.currentMonth.value;
    final last = DateTime(m.year, m.month - 1);
    return StorageService.billsForMonth(last.year, last.month)
        .where((b) => b.isExpense)
        .fold(0.0, (s, b) => s + b.amount);
  }

  double get lastMonthIncome {
    final m = bill.currentMonth.value;
    final last = DateTime(m.year, m.month - 1);
    return StorageService.billsForMonth(last.year, last.month)
        .where((b) => !b.isExpense)
        .fold(0.0, (s, b) => s + b.amount);
  }

  Future<void> setBudget(String categoryId, double amount) async {
    await StorageService.setBudget(categoryId, amount);
    _loadBudgets();
  }

  Future<void> goToBudget() async {
    if (!await AuthService.to.ensureLoggedIn(message: '管理预算需要登录，是否前往登录？')) return;
    await Get.toNamed(Routes.budget);
    _loadBudgets();
  }

  Future<void> goToBudgetDetail(String categoryId) async {
    if (!await AuthService.to.ensureLoggedIn(message: '管理预算需要登录，是否前往登录？')) return;
    await Get.toNamed(Routes.budgetDetail, arguments: categoryId);
    _loadBudgets();
  }
}
