import 'package:hive/hive.dart';

part 'account_record.g.dart';

@HiveType(typeId: 3)
class AccountRecord extends HiveObject {
  @HiveField(0) late String   id;
  @HiveField(1) late String   name;
  @HiveField(2) late String   emoji;
  @HiveField(3) late double   balance;
  @HiveField(4) late DateTime createdAt;
  @HiveField(5) int           sortOrder = 0;
}
