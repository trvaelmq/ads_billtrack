import 'package:get/get.dart';
import 'category_mgmt_controller.dart';

class CategoryMgmtBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CategoryMgmtController>(() => CategoryMgmtController());
  }
}
