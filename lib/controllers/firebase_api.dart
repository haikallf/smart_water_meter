import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:smart_water_meter/utils/notification_manager.dart';

Future<void> handleBackgroundMessage(RemoteMessage message) async {
  print('title: ${message.notification?.title}');
  print("body: ${message.notification?.body}");
  print("payload: ${message.data}");
}

class FirebaseApi {
  final firebaseMesssaging = FirebaseMessaging.instance;
  final localNotifications = FlutterLocalNotificationsPlugin();
  final notificationManager = NotificationManager();
  var deviceToken = "";

  final androidChannel = const AndroidNotificationChannel(
      "high_importance_channel", "High Importance Notifications",
      description: "This channel is used for important notifications",
      importance: Importance.defaultImportance);

  void handleMessage(RemoteMessage? message) {
    if (message == null) return;
    print('title: ${message.notification?.title}');
    print("body: ${message.notification?.body}");
    print("payload: ${message.data}");
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      notificationManager.showNotification(
          id: notification.hashCode,
          title: notification?.title,
          body: notification?.body);

      // if (notification == null) return;
      // localNotifications.show(
      //     notification.hashCode,
      //     notification.title,
      //     notification.body,
      //     NotificationDetails(
      //         android: AndroidNotificationDetails(
      //             androidChannel.id, androidChannel.name,
      //             channelDescription: androidChannel.description,
      //             icon: 'splash')),
      //     payload: jsonEncode(message.toMap()));
    });
  }

  Future initLocalNotifications() async {
    const iOS = DarwinInitializationSettings();
    const android = AndroidInitializationSettings('splash');
    const settings = InitializationSettings(android: android, iOS: iOS);

    await localNotifications.initialize(settings,
        onDidReceiveNotificationResponse:
            (NotificationResponse notificationResponse) async {});

    final platform = localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(androidChannel);
  }

  Future<void> initNotifications() async {
    await firebaseMesssaging.requestPermission();
    final fCMToken = await firebaseMesssaging.getToken();
    deviceToken = fCMToken ?? "";

    print("token: $fCMToken");
    initNotifications();
    notificationManager.initialize();
    // initLocalNotifications();
  }

  String? getDeviceToken() => deviceToken;
}
