import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'storage_service.dart';

class NotificationService {
  NotificationService._();

  static final _plugin = FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const ios = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(android: android, iOS: ios);
    await _plugin.initialize(settings);

    // iOS 14+ 主动申请权限
    await _plugin
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()
        ?.requestPermissions(alert: true, badge: true, sound: true);

    debugPrint('[NotificationService] init done');
  }

  /// 记账后检测预算阈值，在首次越过 80% / 100% 时发通知
  static Future<void> checkBudgetAlert({
    required String categoryId,
    required String categoryLabel,
    required double spent,
    required double budget,
    required double prevSpent,
  }) async {
    if (budget <= 0) return;

    final ratio     = spent / budget;
    final prevRatio = prevSpent / budget;

    final monthKey = () {
      final now = DateTime.now();
      return '${now.year}-${now.month}';
    }();

    // 80% 阈值（只在首次越过时推送）
    if (ratio >= 0.8 && prevRatio < 0.8) {
      final sentKey = 'notif_80_${categoryId}_$monthKey';
      if (!StorageService.hasFlag(sentKey)) {
        await _send(
          id: categoryId.hashCode,
          title: '预算提醒',
          body: '「$categoryLabel」本月支出已超预算 80%，请注意控制消费。',
        );
        await StorageService.setFlag(sentKey);
      }
    }

    // 100% 阈值
    if (ratio >= 1.0 && prevRatio < 1.0) {
      final sentKey = 'notif_100_${categoryId}_$monthKey';
      if (!StorageService.hasFlag(sentKey)) {
        await _send(
          id: categoryId.hashCode + 1000,
          title: '超出预算',
          body: '「$categoryLabel」已超出本月预算，累计支出 ¥${spent.toStringAsFixed(0)}。',
        );
        await StorageService.setFlag(sentKey);
      }
    }
  }

  static Future<void> _send({
    required int id,
    required String title,
    required String body,
  }) async {
    const android = AndroidNotificationDetails(
      'budget_alert',
      '预算提醒',
      channelDescription: '支出超出预算时发送通知',
      importance: Importance.high,
      priority: Priority.high,
    );
    const ios = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: false,
      presentSound: true,
    );
    const details = NotificationDetails(android: android, iOS: ios);
    await _plugin.show(id, title, body, details);
    debugPrint('[NotificationService] sent: $title — $body');
  }
}
