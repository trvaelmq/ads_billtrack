import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/services/account_service.dart';
import 'core/services/risk/risk_gate_service.dart';
import 'core/services/ad_service.dart';
import 'core/services/bill_service.dart';
import 'core/services/recurring_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/storage_service.dart';
import 'core/network/api_client.dart';
import 'core/services/auth_service.dart';
import 'core/theme/app_theme.dart';
import 'router/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await NotificationService.init();
  await Get.putAsync(() async => AccountService());
  // permanent: ApiClient 非 GetxService,防止被 SmartManagement 回收
  Get.put(ApiClient(), permanent: true);
  // RiskGateService 必须在 AdService 之前注册完成：AdService.onInit() 会同步触发
  // loadRewardedAd()，其内部会调用 RiskGateService.to，若此时还未注册会抛异常。
  await Get.putAsync(() => RiskGateService(api: Get.find<ApiClient>()).init());
  await Get.putAsync(() async => AdService());
  await Get.putAsync(() async => BillService());
  await Get.putAsync(() async => RecurringService());
  await Get.putAsync(() async => AuthService(Get.find<ApiClient>()));
  // 静默校验本地 token，不阻塞启动
  AuthService.to.validateOnLaunch();
  runApp(const ZhiTanYanApp());
}

class ZhiTanYanApp extends StatelessWidget {
  const ZhiTanYanApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '智探眼',
      theme: AppTheme.theme,
      initialRoute: Routes.splash,
      getPages: AppPages.pages,
      defaultTransition: Transition.fadeIn,
      debugShowCheckedModeBanner: false,
    );
  }
}
