import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:two_be_wedd/presentation/views/hall_bookings_view/hall_bookings_view.dart';

import '../providers/drawer_destination_provider.dart';

class NotificationsService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  final AndroidNotificationChannel channel = const AndroidNotificationChannel(
    "twoBeWedd", // id
    "twoBeWedd App Notifications", // title
    description:
        'This channel is used for important notifications.', // description
    importance: Importance.high,
  );

  Future<void> requestPermissions() async {
    if (Platform.isIOS || Platform.isMacOS) {
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              IOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              MacOSFlutterLocalNotificationsPlugin>()
          ?.requestPermissions(
            alert: true,
            badge: true,
            sound: true,
          );
    }
  }

  Future<void> showNotification(RemoteNotification? notification) async {
    flutterLocalNotificationsPlugin.show(
      0,
      notification?.title,
      notification?.body,
      const NotificationDetails(
        android: AndroidNotificationDetails(
          "twoBeWedd",
          "twoBeWedd App Notifications",
          icon: "@mipmap/ic_launcher",
          enableVibration: true,
          playSound: true,
          channelShowBadge: true,
          importance: Importance.high,
          priority: Priority.high,
        ),
        iOS: DarwinNotificationDetails(
          presentSound: true,
          presentAlert: true,
          presentBadge: true,
          // attachments: [DarwinNotificationAttachment(picturePath)],
        ),
      ),
    );
  }

  void notificationsOnMessage(BuildContext context) {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      if (Platform.isAndroid) {
        notificationsInitialize(context);
      }
      showNotification(message.notification);
    });
  }

  void notificationsClick(BuildContext context) {
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      debugPrint('onMessageOpenedApp');
      onSelectNotifications(context);
    });
  }

  void notificationsClickTerminated(BuildContext context) async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
      if (value != null) {
        debugPrint('notificationsClickTerminated');
        onSelectNotifications(context);
      }
    });
  }

  void notificationsInitialize(BuildContext context) async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("@mipmap/ic_launcher");
    DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
      onDidReceiveLocalNotification:
          (int id, String? title, String? body, String? payload) =>
              onSelectNotifications(context),
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsDarwin,
    );
    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (response) =>
          onSelectNotifications(context),
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  void onSelectNotifications(BuildContext context) async {
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => HallBookingsView()));
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider.of<DrawerDestinationProvider>(context, listen: false)
            .changeIndex(1, context);
      });
    });
  }
}
