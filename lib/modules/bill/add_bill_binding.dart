import 'package:get/get.dart';
import 'add_bill_controller.dart';

class AddBillBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => AddBillController());
}
