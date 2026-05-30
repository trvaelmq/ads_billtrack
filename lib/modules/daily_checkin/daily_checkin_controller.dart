import 'package:get/get.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/storage_service.dart';

class DailyCheckinController extends GetxController {
  final showReward  = false.obs;
  final earnedCoins = 0.obs;

  bool get hasChecked => StorageService.hasCheckedInToday;
  int  get streak     => StorageService.checkinStreak;

  // 本周7天签到状态
  List<bool> get weekStatus {
    final now = DateTime.now();
    return List.generate(7, (i) {
      final d = now.subtract(Duration(days: 6 - i));
      final last = StorageService.checkinStreak;
      // 简化：今天及之前 streak 天认为已签到
      final diff = now.difference(DateTime(d.year, d.month, d.day)).inDays;
      return diff < last || (diff == 0 && hasChecked);
    });
  }

  Future<void> checkIn() async {
    if (hasChecked) return;
    final coins = await StorageService.doCheckin();
    AdService.to.refreshCoins();
    earnedCoins.value = coins;
    showReward.value  = true;
    await Future.delayed(const Duration(seconds: 2));
    showReward.value = false;
    update();
  }
}
