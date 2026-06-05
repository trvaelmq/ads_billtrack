import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'core/services/ad_service.dart';
import 'core/services/bill_service.dart';
import 'core/services/recurring_service.dart';
import 'core/services/notification_service.dart';
import 'core/services/storage_service.dart';
import 'core/theme/app_theme.dart';
import 'router/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await NotificationService.init();
  await Get.putAsync(() async => AdService());
  await Get.putAsync(() async => BillService());
  await Get.putAsync(() async => RecurringService());
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
