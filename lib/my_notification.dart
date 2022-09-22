import 'package:flutter_local_notifications/flutter_local_notifications.dart';



class MyNotification{
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? payload,
  }) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  static Future _notificationDetails() async {
    return const NotificationDetails(
      iOS: IOSNotificationDetails(),
      android: AndroidNotificationDetails('channelId', 'channelName',
          channelDescription: 'channel description',
          importance: Importance.max),
    );
  }
}
