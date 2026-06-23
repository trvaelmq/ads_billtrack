import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../core/services/ad_service.dart';
import '../../core/services/storage_service.dart';
import '../../router/app_pages.dart';
import 'privacy_dialog.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();
    _init();
  }

  Future<void> _init() async {
    // 未同意隐私政策时弹窗，同意后才初始化广告 SDK
    if (!StorageService.privacyAccepted) {
      final agreed = await Get.dialog<bool>(
        const PrivacyDialog(),
        barrierDismissible: false,
      );
      if (agreed != true) {
        // 用户拒绝，退出应用
        SystemNavigator.pop();
        return;
      }
      await StorageService.setPrivacyAccepted();
      await AdService.to.initAdSdk();
    }

    try {
      AdService.to.showSplashAd();
      await AdService.to.splashDone
          .timeout(const Duration(milliseconds: 5000), onTimeout: () {});
    } catch (_) {}
    if (StorageService.isFirstLaunch) {
      StorageService.setJoinDate();
      StorageService.setFirstLaunchDone();
    }
    // 登录可选：一律进首页，登录由具体操作按需触发
    Get.offAllNamed(Routes.main);
    // 跳转触发后再移除 overlay，目标页已在渲染中
    await AdService.to.dismissSplashAd();
  }
}
