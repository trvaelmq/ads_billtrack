import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/risk_event_record.dart';

/// 发送一条已签名的事件 body,返回是否成功。由调用方(RiskGateService)注入真实网络实现。
typedef RiskEventSender = Future<bool> Function(Map<String, dynamic> body);

/// /risk/event 本地持久化上报队列:断网/失败时保留,成功后移除。
/// 队列里存的是入队时就已签好名的完整 body,重试时原样重发。
class RiskEventQueue {
  final Box<RiskEventRecord> _box;
  RiskEventQueue(this._box);

  int get pendingCount => _box.length;

  Future<void> enqueue(Map<String, dynamic> signedBody) async {
    final record = RiskEventRecord()
      ..id = const Uuid().v4()
      ..signedBodyJson = jsonEncode(signedBody)
      ..createdAt = DateTime.now();
    await _box.put(record.id, record);
  }

  /// 遍历队列尝试重发,成功的记录从队列删除,失败的保留。
  Future<void> flush({required RiskEventSender sender}) async {
    for (final key in _box.keys.toList()) {
      final record = _box.get(key);
      if (record == null) continue;
      final body = jsonDecode(record.signedBodyJson) as Map<String, dynamic>;
      final ok = await sender(body);
      if (ok) await _box.delete(key);
    }
  }
}
