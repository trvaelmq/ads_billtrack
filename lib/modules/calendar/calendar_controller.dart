import 'package:get/get.dart';
import '../../data/models/bill_record.dart';
import '../../core/services/storage_service.dart';

class CalendarController extends GetxController {
  final Rx<DateTime> displayMonth = DateTime.now().obs;
  final RxList<BillRecord> monthBills = <BillRecord>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadMonthBills();
  }

  void loadMonthBills() {
    final m = displayMonth.value;
    monthBills.value = StorageService.billsForMonth(m.year, m.month);
  }

  void changeMonth(int delta) {
    final m = displayMonth.value;
    displayMonth.value = DateTime(m.year, m.month + delta);
    loadMonthBills();
  }

  Map<int, double> get dailyNetAmounts {
    final result = <int, double>{};
    for (final b in monthBills) {
      final day = b.date.day;
      result[day] = (result[day] ?? 0) + (b.isExpense ? -b.amount : b.amount);
    }
    return result;
  }

  double get totalExpense =>
      monthBills.where((b) => b.isExpense).fold(0.0, (s, b) => s + b.amount);
  double get totalIncome =>
      monthBills.where((b) => !b.isExpense).fold(0.0, (s, b) => s + b.amount);

  List<BillRecord> billsForDay(DateTime day) => monthBills
      .where((b) =>
          b.date.year == day.year &&
          b.date.month == day.month &&
          b.date.day == day.day)
      .toList()
    ..sort((a, b) => b.date.compareTo(a.date));

  String get monthLabel {
    final m = displayMonth.value;
    return '${m.year}年${m.month}月';
  }

  bool get canGoForward {
    final m = displayMonth.value;
    final now = DateTime.now();
    return !(m.year == now.year && m.month == now.month);
  }
}
