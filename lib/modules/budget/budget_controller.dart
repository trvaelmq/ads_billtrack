import 'package:get/get.dart';
import '../../core/services/storage_service.dart';

class BudgetController extends GetxController {
  final budgets = <String, double>{}.obs;

  @override
  void onInit() {
    super.onInit();
    budgets.value = Map.from(StorageService.budgets);
  }

  Future<void> setBudget(String categoryId, double amount) async {
    await StorageService.setBudget(categoryId, amount);
    budgets[categoryId] = amount;
  }
}
