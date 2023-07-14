import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;
import 'package:valdulivi2023_giovani1/notifications/daily_notification.dart';

import 'weekly_notification.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    tz.initializeTimeZones();
    tz.setLocalLocation(
      tz.getLocation('Europe/Berlin'),
    );

    AndroidInitializationSettings initializationSettingsAndroid =
        const AndroidInitializationSettings('@mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: (
          int id,
          String? title,
          String? body,
          String? payload,
        ) async {});

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );
    await notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (
          NotificationResponse notificationResponse,
        ) async {});

    tz.TZDateTime sundaySchedule = tz.TZDateTime(tz.local, 2023, 7, 23, 16, 00);
    weeklyNotification(
      'Culto alle ore 17:00',
      'Cena alle ore 19:30',
      sundaySchedule,
    );

    tz.TZDateTime bibleStudySchedule =
        tz.TZDateTime(tz.local, 2023, 7, 24, 10, 20);
    dailyNotification(
      'Studio Biblico',
      'Alle ore 11:00',
      bibleStudySchedule,
    );

    tz.TZDateTime worshipSchedule =
        tz.TZDateTime(tz.local, 2023, 7, 24, 17, 45);
    dailyNotification(
      'Culto',
      'Alle ore 18:30',
      worshipSchedule,
    );
  }

  notificationDetails() {
    return const NotificationDetails(
      android: AndroidNotificationDetails(
        'channelId',
        'channelName',
        importance: Importance.max,
      ),
      iOS: DarwinNotificationDetails(),
    );
  }

  Future showNotification(
      {int id = 0, String? title, String? body, String? payLoad}) async {
    return notificationsPlugin.show(
        id, title, body, await notificationDetails());
  }
}
