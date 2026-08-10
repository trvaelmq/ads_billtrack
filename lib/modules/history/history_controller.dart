import 'package:get/get.dart';
import '../../core/services/risk/risk_gate_service.dart';
import '../../core/services/risk/risk_models.dart';

class HistoryController extends GetxController {
  final records = <AdViewRecord>[].obs;
  final isLoading = false.obs;
  final hasError = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadRecords();
  }

  Future<void> loadRecords() async {
    isLoading.value = true;
    hasError.value = false;
    try {
      final result = await RiskGateService.to.fetchAdViews();
      records.value = result.records;
    } catch (_) {
      hasError.value = true;
    } finally {
      isLoading.value = false;
    }
  }
}
