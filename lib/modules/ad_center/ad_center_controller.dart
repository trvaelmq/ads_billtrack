import 'package:get/get.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/storage_service.dart';
import '../../router/app_pages.dart';

class AdCenterController extends GetxController {
  final ad = AdService.to;

  final checkedInToday = false.obs;
  final checkinStreak  = 0.obs;

  @override
  void onInit() {
    super.onInit();
    _refreshCheckin();
  }

  void _refreshCheckin() {
    checkedInToday.value = StorageService.hasCheckedInToday;
    checkinStreak.value  = StorageService.checkinStreak;
  }

  Future<void> goToCheckin() async {
    await Get.toNamed(Routes.dailyCheckin);
    _refreshCheckin();
  }

  void watchRewarded() {
    if (ad.isRewardedReady.value) {
      ad.showRewardedAd();
    } else {
      ad.loadRewardedAd();
      Get.snackbar('加载中', '广告加载中，请稍候再试', snackPosition: SnackPosition.BOTTOM);
    }
  }
}
