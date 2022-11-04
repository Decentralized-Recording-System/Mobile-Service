import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationPlugin =
      FlutterLocalNotificationsPlugin();
  static void initialize() {
    final InitializationSettings initializationSettings =
        InitializationSettings(
            android: AndroidInitializationSettings('@mipmap/ic_launcher'));
    _notificationPlugin.initialize(
      initializationSettings,
    );
  }

  static void display(RemoteMessage message) async {
    try {
      final id =
          int.parse((DateTime.now().microsecondsSinceEpoch / 1000).toString());
      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "easyapproach", "easyapproach channel",
              importance: Importance.max, priority: Priority.high));
      await _notificationPlugin.show(id, message.notification!.title,
          message.notification!.body, notificationDetails);
    } catch (e) {
      print(e.toString());
    }
  }
}
