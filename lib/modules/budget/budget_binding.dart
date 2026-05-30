import 'package:get/get.dart';
import 'budget_controller.dart';

class BudgetBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => BudgetController());
}
