// import 'package:daily_verse/view/home/tab1.dart';
import 'package:flutter/material.dart';
import 'dart:io' show Platform;
import 'package:rxdart/subjects.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotifyManager {
  // String? lastVerse;

  // Future<String?> getVerse() async{
  //   final prefs = await SharedPreferences.getInstance();
  //     lastVerse= prefs.getString('lastVerse')!;
  //     return lastVerse;
  // }

  FlutterLocalNotificationsPlugin? flutterLocalNotificationsPlugin;
  var initSetting;
  BehaviorSubject<ReceiveNotification> get didReceiveLocalNotificationSubject =>
      BehaviorSubject<ReceiveNotification>();

  LocalNotifyManager.init() {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    if (Platform.isIOS) {
      requestIOSPermission();
    }
    initializePlatform();
  }

  requestIOSPermission() {
    flutterLocalNotificationsPlugin!
        .resolvePlatformSpecificImplementation<
            IOSFlutterLocalNotificationsPlugin>()!
        .requestPermissions(alert: true, badge: true, sound: true);
  }

  initializePlatform() {
    var initSettingAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    var initSettingIOS = IOSInitializationSettings(
        requestSoundPermission: true,
        requestBadgePermission: true,
        requestAlertPermission: true,
        onDidReceiveLocalNotification: (id, title, body, payload) async {
          ReceiveNotification notification =
              ReceiveNotification(id, title, body, payload);
          didReceiveLocalNotificationSubject.add(notification);
        });
    initSetting = InitializationSettings(iOS: initSettingIOS, android: initSettingAndroid);
  }

  setOnNotificationReceive(Function onNotificationReceive) {
    didReceiveLocalNotificationSubject.listen((notification) {
      onNotificationReceive(notification);
    });
  }

  setOnNotificationClick(Function setOnNotificationClick) async {
    await flutterLocalNotificationsPlugin!.initialize(initSetting,
        onSelectNotification: (payload) async {
      setOnNotificationClick(payload);
    });
  }

  Future<void> showNotification({int id = 0,
    // String? title,
    String? body,
    String? payload,}) async {
      final prefs = await SharedPreferences.getInstance();
      String lastVerse= prefs.getString('lastVerse')!;
    var androidChannel = const AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME',
        importance: Importance.max, priority: Priority.high, playSound: true);
        var iosChannel = const IOSNotificationDetails();
        var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
        await flutterLocalNotificationsPlugin!.show(0, 'Message of the day', lastVerse, platformChannel, payload: payload);
  }

  Future<void> showScheduledNotification({int id = 0,
    // String? title,
    // String? body,
    String? payload,}) async {
      final prefs = await SharedPreferences.getInstance();
      String lastVerse= prefs.getString('lastVerse')!;
      var scheduleNotificationDateTime = DateTime.now().add(const Duration(seconds: 3));
      var androidChannel = const AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME',
        importance: Importance.max, priority: Priority.high, playSound: true);
        var iosChannel = const IOSNotificationDetails();
        var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
        await flutterLocalNotificationsPlugin!.schedule(0, 'Message of the day' , lastVerse, scheduleNotificationDateTime,platformChannel, payload: payload);
  }

  Future<void> showNotificationPerDay({int id = 0,
    // String? title,
    // String? body,
    String? payload,}) async {
      final prefs = await SharedPreferences.getInstance();
      String lastVerse= prefs.getString('lastVerse')!;
      // var time =Time(12,00,00);
    var androidChannel = const AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME',
        importance: Importance.max, priority: Priority.high, playSound: true);
        var iosChannel = const IOSNotificationDetails();
        var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
        await flutterLocalNotificationsPlugin!.periodicallyShow(0, 'Message of the day', lastVerse, RepeatInterval.daily,platformChannel, payload: payload);
  }

  Future<void> showNotificationPerMinute({int id = 0,
    // String? title,
    String? body,
    String? payload,}) async {
      // final prefs = await SharedPreferences.getInstance();
      // String lastVerse= prefs.getString('lastVerse')!;
      // var time =Time(12,00,00);
    var androidChannel = const AndroidNotificationDetails(
        'CHANNEL_ID', 'CHANNEL_NAME',
        importance: Importance.max, priority: Priority.high, playSound: true);
        var iosChannel = const IOSNotificationDetails();
        var platformChannel = NotificationDetails(android: androidChannel, iOS: iosChannel);
        await flutterLocalNotificationsPlugin!.periodicallyShow(0, 'Message of the day', body, RepeatInterval.everyMinute ,platformChannel, payload: payload);
  }

  Future<void> cancelNotification(int id) async{
    await flutterLocalNotificationsPlugin!.cancel(id);
  }

}

LocalNotifyManager localNotifyManager = LocalNotifyManager.init();


class ReceiveNotification {
  final int id;
  final String? title;
  final String? body;
  final String? payload;

  ReceiveNotification(@required this.id, @required this.title,
      @required this.body, @required this.payload);
}
