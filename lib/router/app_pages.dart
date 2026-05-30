import 'package:get/get.dart';
import '../modules/splash/splash_view.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/onboarding/onboarding_view.dart';
import '../modules/onboarding/onboarding_binding.dart';
import '../modules/home/main_view.dart';
import '../modules/home/main_binding.dart';
import '../modules/bill/add_bill_view.dart';
import '../modules/bill/add_bill_binding.dart';
import '../modules/stats/stats_view.dart';
import '../modules/stats/stats_binding.dart';
import '../modules/budget/budget_view.dart';
import '../modules/budget/budget_binding.dart';
import '../modules/split/split_view.dart';
import '../modules/history/history_view.dart';
import '../modules/history/history_binding.dart';
import '../modules/daily_checkin/daily_checkin_view.dart';
import '../modules/daily_checkin/daily_checkin_binding.dart';
import '../modules/budget_detail/budget_detail_view.dart';
import '../modules/budget_detail/budget_detail_controller.dart';
import '../modules/calendar/calendar_view.dart';
import '../modules/calendar/calendar_binding.dart';
import '../modules/calendar/day_detail_view.dart';
import '../modules/category_mgmt/category_mgmt_view.dart';
import '../modules/category_mgmt/category_mgmt_binding.dart';

abstract class Routes {
  static const splash        = '/';
  static const onboarding    = '/onboarding';
  static const main          = '/main';
  static const addBill       = '/add-bill';
  static const stats         = '/stats';
  static const budget        = '/budget';
  static const split         = '/split';
  static const history       = '/history';
  static const dailyCheckin  = '/daily-checkin';
  static const budgetDetail  = '/budget-detail';
  static const calendar      = '/calendar';
  static const dayDetail     = '/calendar/day';
  static const categoryMgmt  = '/category-mgmt';
}

class AppPages {
  static final pages = [
    GetPage(name: Routes.splash,       page: () => const SplashView(),       binding: SplashBinding()),
    GetPage(name: Routes.onboarding,   page: () => const OnboardingView(),   binding: OnboardingBinding()),
    GetPage(name: Routes.main,         page: () => const MainView(),         binding: MainBinding()),
    GetPage(name: Routes.addBill,      page: () => const AddBillView(),      binding: AddBillBinding()),
    GetPage(name: Routes.stats,        page: () => const StatsView(),        binding: StatsBinding()),
    GetPage(name: Routes.budget,       page: () => const BudgetView(),       binding: BudgetBinding()),
    GetPage(name: Routes.split,        page: () => const SplitView()),
    GetPage(name: Routes.history,      page: () => const HistoryView(),      binding: HistoryBinding()),
    GetPage(name: Routes.dailyCheckin, page: () => const DailyCheckinView(), binding: DailyCheckinBinding()),
    GetPage(
      name: Routes.budgetDetail,
      page: () => const BudgetDetailView(),
      binding: BindingsBuilder(() {
        final categoryId = Get.arguments as String;
        Get.lazyPut(() => BudgetDetailController(categoryId: categoryId));
      }),
    ),
    GetPage(
      name: Routes.calendar,
      page: () => const CalendarView(),
      binding: CalendarBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.dayDetail,
      page: () => DayDetailView(date: Get.arguments as DateTime),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.categoryMgmt,
      page: () => const CategoryMgmtView(),
      binding: CategoryMgmtBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
