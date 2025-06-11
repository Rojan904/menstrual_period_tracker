import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationApi {
  static final _notifications = FlutterLocalNotificationsPlugin();

  static Future init({bool scheduled = false}) async {

    var initAndroidSettings =
        const AndroidInitializationSettings('mipmap/launcher_icon');
    // var ios = const DarwinInitializationSettings();

    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
            requestAlertPermission: true,
            requestBadgePermission: true,
            requestSoundPermission: true,
            onDidReceiveLocalNotification: (id, title, body, payload) async {});

    if (Platform.isAndroid) {
      _notifications
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()!
          .requestPermission();
    }
    if (Platform.isIOS) {
      _notifications
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()!
          .requestPermissions();
    }

    final settings = InitializationSettings(
      android: initAndroidSettings,
      iOS: initializationSettingsDarwin,
    );
    await _notifications.initialize(
      settings,
      // onDidReceiveBackgroundNotificationResponse:
      //     (NotificationResponse notificationResponse) async {},
    );
  }

  static Future showScheduledNotification(
          {int id = 0,
          String? title,
          String? body,
          String? payload,
          required DateTime scheduledDate}) async =>
      _notifications.zonedSchedule(
          id,
          title,
          body,
          tz.TZDateTime.from(scheduledDate, tz.local),
          await _notificationDetails(),
          uiLocalNotificationDateInterpretation:
              UILocalNotificationDateInterpretation.absoluteTime);
  void showNotificationI({
    int id = 0,
    String? title,
    String? body,
    String? paylod,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );

  static Future showNotification({
    int id = 0,
    String? title,
    String? body,
    String? paylod,
  }) async =>
      _notifications.show(
        id,
        title,
        body,
        await _notificationDetails(),
      );

  static Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails(
          "channelId",
          "channelName",
          importance: Importance.max,
          priority: Priority.high,
          playSound: true,
          // sound: RawResourceAndroidNotificationSound('notification'),
        ),
        iOS: DarwinNotificationDetails());
    // iOS: IOSNotificationDetails());
  }

  static Future stopNotification() async {
    _notifications.cancelAll();
  }
}
