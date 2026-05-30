import 'package:get/get.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/bill_service.dart';
import '../../core/services/storage_service.dart';
import '../../data/models/bill_record.dart';

class BudgetDetailController extends GetxController {
  final String categoryId;
  BudgetDetailController({required this.categoryId});

  final bill   = BillService.to;
  final budget = 0.0.obs;

  BillCategory get cat => AppConstants.categoryById(categoryId);

  List<BillRecord> get categoryBills => bill.bills
      .where((b) => b.isExpense && b.category == categoryId)
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));

  double get spent => categoryBills.fold(0.0, (s, b) => s + b.amount);

  @override
  void onInit() {
    super.onInit();
    budget.value = StorageService.budgets[categoryId] ?? 0.0;
  }

  Future<void> setBudget(double amount) async {
    await StorageService.setBudget(categoryId, amount);
    budget.value = amount;
    // 通知 ReportController 刷新（如果已注册）
    try {
      Get.find<dynamic>(tag: 'report_refresh')?.call();
    } catch (_) {}
  }
}
