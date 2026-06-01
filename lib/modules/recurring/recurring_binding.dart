import 'package:get/get.dart';
import 'recurring_controller.dart';

class RecurringBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecurringController());
  }
}
