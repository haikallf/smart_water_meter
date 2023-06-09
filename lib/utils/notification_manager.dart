import "package:flutter_local_notifications/flutter_local_notifications.dart";

class NotificationManager {
  final _notifications = FlutterLocalNotificationsPlugin();

  Future initialize({bool initScheduled = false}) async {
    const android = AndroidInitializationSettings('ic_launcher');
    DarwinInitializationSettings iOS = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
        onDidReceiveLocalNotification: _onDidReceiveLocalNotification);
    InitializationSettings settings =
        InitializationSettings(android: android, iOS: iOS);
    await _notifications.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});
  }

  Future _notificationDetails() async {
    return const NotificationDetails(
        android: AndroidNotificationDetails("channelId", "channelName",
            channelDescription: "channelDesc",
            importance: Importance.max,
            priority: Priority.max,
            playSound: true),
        iOS: DarwinNotificationDetails());
  }

  Future showNotification(
          {int id = 0, String? title, String? body, String? payload}) async =>
      _notifications.show(id, title, body, await _notificationDetails(),
          payload: payload);

  void _onDidReceiveLocalNotification(
      int id, String? title, String? body, String? payload) async {
    print("id: $id");
  }

  void onSelectNotification(String? payload) {
    print("payload: $payload");
  }
}
