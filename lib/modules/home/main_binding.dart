import 'package:get/get.dart';
import 'main_controller.dart';
import '../bill/bill_controller.dart';
import '../report/report_controller.dart';
import '../profile/profile_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MainController());
    Get.lazyPut(() => BillController());
    Get.lazyPut(() => ReportController());
    Get.lazyPut(() => ProfileController());
  }
}
