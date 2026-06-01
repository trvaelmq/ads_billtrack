import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../data/models/recurring_rule.dart';
import 'bill_service.dart';
import 'storage_service.dart';

class RecurringService extends GetxService {
  static RecurringService get to => Get.find();

  final rules = <RecurringRule>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadRules();
  }

  void _loadRules() {
    rules.assignAll(StorageService.allRecurringRules);
  }

  List<RecurringRule> get dueRules {
    final today = DateTime.now();
    return rules.where((r) =>
      r.isActive &&
      !r.nextDueDate.isAfter(DateTime(today.year, today.month, today.day + 1))
    ).toList();
  }

  Future<void> addRule({
    required String title,
    required double amount,
    required String category,
    required bool isExpense,
    required String frequency,
    required DateTime startDate,
    String note = '',
  }) async {
    final rule = RecurringRule()
      ..id = const Uuid().v4()
      ..title = title
      ..amount = amount
      ..category = category
      ..isExpense = isExpense
      ..frequency = frequency
      ..nextDueDate = startDate
      ..isActive = true
      ..note = note;
    await StorageService.saveRecurringRule(rule);
    _loadRules();
  }

  Future<void> updateRule(RecurringRule rule) async {
    await StorageService.saveRecurringRule(rule);
    _loadRules();
  }

  Future<void> deleteRule(String id) async {
    await StorageService.deleteRecurringRule(id);
    _loadRules();
  }

  /// 记录到期规则：写入账单并推算下次到期日
  Future<void> recordDue(RecurringRule rule) async {
    await BillService.to.addBill(
      amount: rule.amount,
      type: rule.isExpense ? 'expense' : 'income',
      category: rule.category,
      date: DateTime.now(),
      note: rule.note.isEmpty ? rule.title : rule.note,
    );
    rule.nextDueDate = _nextDate(rule.nextDueDate, rule.frequency);
    await StorageService.saveRecurringRule(rule);
    _loadRules();
  }

  DateTime _nextDate(DateTime from, String frequency) {
    switch (frequency) {
      case 'daily':   return from.add(const Duration(days: 1));
      case 'weekly':  return from.add(const Duration(days: 7));
      case 'yearly':  return DateTime(from.year + 1, from.month, from.day);
      default:        // monthly
        final nextMonth = from.month == 12 ? 1 : from.month + 1;
        final nextYear  = from.month == 12 ? from.year + 1 : from.year;
        final lastDay   = DateTime(nextYear, nextMonth + 1, 0).day;
        return DateTime(nextYear, nextMonth, from.day.clamp(1, lastDay));
    }
  }
}
