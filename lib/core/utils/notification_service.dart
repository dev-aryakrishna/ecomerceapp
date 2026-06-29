import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  Future<void> init() async {
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const initSettings = InitializationSettings(
      android: androidSettings,
    );

    await _plugin.initialize(initSettings);
  }

  Future<void> showOrderSuccessNotification({
    required String orderId,
    required double totalAmount,
  }) async {
    const androidDetails = AndroidNotificationDetails(
      'order_channel',
      'Order Notifications',
      channelDescription: 'Notifications for order updates',
      importance: Importance.high,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidDetails,
    );

    await _plugin.show(
      0,
      'Order Placed Successfully! 🎉',
      'Order #$orderId — Total: \$$totalAmount',
      notificationDetails,
    );
  }
}