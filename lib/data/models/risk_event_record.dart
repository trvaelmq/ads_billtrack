import 'package:hive/hive.dart';

part 'risk_event_record.g.dart';

/// /risk/event 待上报的一条记录:signedBodyJson 是入队时已签好名的完整请求体,
/// 重试时原样重发，不重新签名(签名对应事件发生的真实时刻)。
@HiveType(typeId: 4)
class RiskEventRecord extends HiveObject {
  @HiveField(0) late String id;
  @HiveField(1) late String signedBodyJson;
  @HiveField(2) late DateTime createdAt;
}
