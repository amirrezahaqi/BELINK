import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
// ignore: depend_on_referenced_packages
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

// تنظیمات و مقدار دهی های اولیه نوت فیکیشن
  Future<void> initNotification() async {
    // تنظیمات اندروید
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("beelink");
    // تنظیمات Ios
    var initializationIosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
      onDidReceiveLocalNotification: (id, title, body, payload) async {},
    );
    // ست کردن تنظیمات اولیه
    var initializationSettings = InitializationSettings(
        android: androidSettings, iOS: initializationIosSettings);
    await notificationsPlugin.initialize(initializationSettings);
  }

  // تنظیم جزئیات نوتفیکیشن
  notificationDetails() {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
            'LinkeryNotifId', 'LinkeryNotificationChannel',
            icon: "notificon",
            importance: Importance.max,
            actions: [AndroidNotificationAction("ShowPage", "show")],
            playSound: true),
        iOS: DarwinNotificationDetails());
  }

  // ارسال نوتفیکیشن
  Future<void> showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }

  Future<void> onTimeShowNotification(
      {int id = 0,
      String? title,
      String? body,
      String? payLoad,
      required DateTime sendTime}) async {
    return notificationsPlugin.zonedSchedule(
      id,
      title,
      body,
      tz.TZDateTime.from(sendTime, tz.local),
      await notificationDetails(),
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      androidAllowWhileIdle: true,
    );
  }
}
