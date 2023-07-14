import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> weeklyNotification(title, body, schedule) async {
  await notificationsPlugin.zonedSchedule(
    0,
    title,
    body,
    schedule,
    NotificationService().notificationDetails(),
    androidScheduleMode: AndroidScheduleMode.exact,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime,
  );
}
