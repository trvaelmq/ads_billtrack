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

  bool _flushing = false;

  int get pendingCount => _box.length;

  Future<void> enqueue(Map<String, dynamic> signedBody) async {
    final record = RiskEventRecord()
      ..id = const Uuid().v4()
      ..signedBodyJson = jsonEncode(signedBody)
      ..createdAt = DateTime.now();
    await _box.put(record.id, record);
  }

  /// 遍历队列尝试重发,成功的记录从队列删除,失败的保留;
  /// 单条记录处理异常(网络异常/脏数据)不影响其余记录,损坏到无法解析的记录直接丢弃(重试也不会成功)。
  Future<void> flush({required RiskEventSender sender}) async {
    if (_flushing) return; // 已有一次 flush 在进行中,避免同一条记录被并发重复发送
    _flushing = true;
    try {
      for (final key in _box.keys.toList()) {
        final record = _box.get(key);
        if (record == null) continue;
        Map<String, dynamic> body;
        try {
          body = jsonDecode(record.signedBodyJson) as Map<String, dynamic>;
        } catch (_) {
          await _box.delete(key); // 无法解析,重试也不会成功,直接丢弃
          continue;
        }
        try {
          final ok = await sender(body);
          if (ok) await _box.delete(key);
        } catch (_) {
          // sender 抛异常(网络异常等)按失败处理,记录保留,继续处理下一条
        }
      }
    } finally {
      _flushing = false;
    }
  }
}
