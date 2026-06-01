import 'package:hive/hive.dart';

part 'recurring_rule.g.dart';

@HiveType(typeId: 2)
class RecurringRule extends HiveObject {
  @HiveField(0) late String   id;
  @HiveField(1) late String   title;
  @HiveField(2) late double   amount;
  @HiveField(3) late String   category;
  @HiveField(4) late bool     isExpense;
  @HiveField(5) late String   frequency; // 'daily'|'weekly'|'monthly'|'yearly'
  @HiveField(6) late DateTime nextDueDate;
  @HiveField(7) late bool     isActive;
  @HiveField(8) late String   note;
}
