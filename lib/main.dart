import "package:flutter/material.dart";
import 'package:permission_handler/permission_handler.dart';

import 'app.dart';
import 'notifications/notification_service.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });

  NotificationService().initNotification();

  runApp(const Valdulivi2023Giovani1());
}
