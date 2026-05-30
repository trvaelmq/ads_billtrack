import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'main_controller.dart';
import 'home_view.dart';
import '../tools/tools_view.dart';
import '../report/report_view.dart';
import '../profile/profile_view.dart';
import '../../core/theme/app_theme.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    final pages = const [
      HomeView(),
      ReportView(),
      ToolsView(),
      ProfileView(),
    ];

    return Obx(() => Scaffold(
          body: AnimatedSwitcher(
            duration: const Duration(milliseconds: 150),
            switchInCurve: Curves.easeIn,
            switchOutCurve: Curves.easeOut,
            transitionBuilder: (child, animation) =>
                FadeTransition(opacity: animation, child: child),
            child: KeyedSubtree(
              key: ValueKey(controller.currentIndex.value),
              child: pages[controller.currentIndex.value],
            ),
          ),
          bottomNavigationBar: Container(
            decoration: BoxDecoration(
              color: AppTheme.cardColor,
              border: const Border(
                  top: BorderSide(color: AppTheme.divider, width: 0.5)),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 8,
                    offset: const Offset(0, -2)),
              ],
            ),
            child: BottomNavigationBar(
              currentIndex: controller.currentIndex.value,
              onTap: controller.changePage,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: AppTheme.accent,
              unselectedItemColor: AppTheme.textSecondary,
              selectedLabelStyle: const TextStyle(
                  fontSize: 11, fontWeight: FontWeight.w600),
              unselectedLabelStyle: const TextStyle(fontSize: 11),
              type: BottomNavigationBarType.fixed,
              items: [
                _item(Icons.home_outlined, Icons.home_rounded, '首页', 0,
                    controller.currentIndex.value),
                _item(Icons.bar_chart_outlined, Icons.bar_chart_rounded,
                    '统计', 1, controller.currentIndex.value),
                _item(Icons.calculate_outlined,
                    Icons.calculate_rounded, '工具', 2,
                    controller.currentIndex.value),
                _item(Icons.person_outline_rounded, Icons.person_rounded,
                    '我的', 3, controller.currentIndex.value),
              ],
            ),
          ),
        ));
  }

  BottomNavigationBarItem _item(IconData outline, IconData filled,
      String label, int index, int current) {
    return BottomNavigationBarItem(
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, anim) => ScaleTransition(
          scale: Tween<double>(begin: 0.7, end: 1.0).animate(
              CurvedAnimation(parent: anim, curve: Curves.elasticOut)),
          child: FadeTransition(opacity: anim, child: child),
        ),
        child: Icon(current == index ? filled : outline,
            key: ValueKey(current == index)),
      ),
      label: label,
    );
  }
}
