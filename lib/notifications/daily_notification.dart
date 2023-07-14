import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'notification_service.dart';

final FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> dailyNotification(title, body, schedule) async {
  for (int i = 0; i < 5; i++) {
    await notificationsPlugin.zonedSchedule(
        i, title, body, schedule, NotificationService().notificationDetails(),
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
        androidScheduleMode: AndroidScheduleMode.exact,
        matchDateTimeComponents: DateTimeComponents.dayOfWeekAndTime);

    schedule = schedule.add(const Duration(days: 1));
  }
}
