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
import '../modules/split/split_history_view.dart';
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
import '../modules/health_score/health_score_view.dart';
import '../modules/recurring/recurring_view.dart';
import '../modules/recurring/recurring_edit_view.dart';
import '../modules/recurring/recurring_binding.dart';
import '../modules/report/heatmap_view.dart';
import '../modules/report/category_drill_view.dart';
import '../modules/report/compare_view.dart';
import '../modules/account/account_list_view.dart';
import '../modules/auth/login_view.dart';
import '../modules/auth/login_controller.dart';
import '../modules/auth/register_view.dart';
import '../modules/auth/register_controller.dart';

abstract class Routes {
  static const splash        = '/';
  static const onboarding    = '/onboarding';
  static const main          = '/main';
  static const addBill       = '/add-bill';
  static const stats         = '/stats';
  static const budget        = '/budget';
  static const split         = '/split';
  static const splitHistory  = '/split/history';
  static const history       = '/history';
  static const dailyCheckin  = '/daily-checkin';
  static const budgetDetail  = '/budget-detail';
  static const calendar      = '/calendar';
  static const dayDetail     = '/calendar/day';
  static const categoryMgmt  = '/category-mgmt';
  static const healthScore   = '/health-score';
  static const recurring     = '/recurring';
  static const recurringEdit = '/recurring/edit';
  static const heatmap       = '/report/heatmap';
  static const categoryDrill = '/report/category';
  static const compare       = '/report/compare';
  static const accounts      = '/accounts';
  static const login         = '/login';
  static const register      = '/register';
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
    GetPage(name: Routes.splitHistory, page: () => const SplitHistoryView()),
    GetPage(name: Routes.history,      page: () => const HistoryView(),      binding: HistoryBinding()),
    GetPage(name: Routes.dailyCheckin, page: () => const DailyCheckinView(), binding: DailyCheckinBinding()),
    GetPage(
      name: Routes.budgetDetail,
      page: () => const BudgetDetailView(),
      binding: BindingsBuilder(() {
        // 防御：缺参数时兜底为空串，categoryById 会回退到默认分类，避免白屏崩溃
        final categoryId = (Get.arguments as String?) ?? '';
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
      // 防御：缺参数时兜底为今天，避免白屏崩溃
      page: () => DayDetailView(date: (Get.arguments as DateTime?) ?? DateTime.now()),
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
    GetPage(
      name: Routes.healthScore,
      page: () => const HealthScoreView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.recurring,
      page: () => const RecurringView(),
      binding: RecurringBinding(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.recurringEdit,
      page: () => const RecurringEditView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.heatmap,
      page: () => const HeatmapView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.categoryDrill,
      page: () => const CategoryDrillView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.compare,
      page: () => const CompareView(),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(name: Routes.accounts, page: () => const AccountListView()),
    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => LoginController())),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
    GetPage(
      name: Routes.register,
      page: () => const RegisterView(),
      binding: BindingsBuilder(() => Get.lazyPut(() => RegisterController())),
      transition: Transition.cupertino,
      transitionDuration: const Duration(milliseconds: 300),
    ),
  ];
}
