import 'package:get/get.dart';
import '../../core/services/storage_service.dart';
import '../../data/models/ad_record.dart';

class HistoryController extends GetxController {
  final records = <AdRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadRecords();
  }

  void loadRecords() => records.value = StorageService.adRecords;

  int get todayCount => StorageService.todayAdRecords.length;
}
