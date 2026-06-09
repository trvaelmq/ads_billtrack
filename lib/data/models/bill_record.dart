import 'package:hive/hive.dart';

part 'bill_record.g.dart';

@HiveType(typeId: 0)
class BillRecord extends HiveObject {
  @HiveField(0) late String   id;
  @HiveField(1) late double   amount;   // 始终为正数
  @HiveField(2) late String   type;     // 'expense' | 'income'
  @HiveField(3) late String   category; // 分类 id
  @HiveField(4) late DateTime date;
  @HiveField(5) late String   note;
  @HiveField(6) List<String>? tags;   // 新增，可空，旧数据兼容
  @HiveField(7) String? accountId;   // 所属账户，可空（旧数据兼容）

  bool get isExpense => type == 'expense';
}
