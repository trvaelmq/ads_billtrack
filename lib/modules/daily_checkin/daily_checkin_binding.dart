import 'package:get/get.dart';
import 'daily_checkin_controller.dart';

class DailyCheckinBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut(() => DailyCheckinController());
}
