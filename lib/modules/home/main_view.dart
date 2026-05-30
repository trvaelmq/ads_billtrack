import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import 'home_view.dart';
import '../bill/bill_view.dart';
import '../report/report_view.dart';
import '../profile/profile_view.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = [
      const HomeView(),
      const BillView(),
      const ReportView(),
      const ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(index: controller.currentIndex.value, children: pages),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changePage,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_outlined),        activeIcon: Icon(Icons.home),         label: '首页'),
              BottomNavigationBarItem(icon: Icon(Icons.receipt_long_outlined), activeIcon: Icon(Icons.receipt_long), label: '账单'),
              BottomNavigationBarItem(icon: Icon(Icons.bar_chart_outlined),     activeIcon: Icon(Icons.bar_chart),    label: '统计'),
              BottomNavigationBarItem(icon: Icon(Icons.person_outline),        activeIcon: Icon(Icons.person),       label: '我的'),
            ],
          ),
        ));
  }
}
