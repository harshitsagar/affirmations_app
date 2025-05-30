import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class NotificationUtils {
  static const notificationChannelId = "com.Affirmations.app";
  static const notificationChannelName ="Affirmations";
  static const notificationChannelDescription = "Channel for app notifications.";

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  /// Singleton instance
  factory NotificationUtils() {
    _instance ??= NotificationUtils._();
    return _instance!;
  }

  NotificationUtils._();

  static NotificationUtils? _instance;

  late AndroidInitializationSettings initializationSettingsAndroid;
  late AndroidNotificationChannel androidNotificationChannel;

  Future<void> init() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');

    initializationSettingsAndroid = const AndroidInitializationSettings('@mipmap/ic_launcher');
    const DarwinInitializationSettings initializationSettingsIOS = DarwinInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? response) async {
        if (response?.payload != null) {
          final Map<String, dynamic> data = jsonDecode(response!.payload!);
          handleNotificationRedirection(data);
        }
      },
    );

    androidNotificationChannel = const AndroidNotificationChannel(
      notificationChannelId,
      notificationChannelName,
      description: notificationChannelDescription,
      importance: Importance.max,
      playSound: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  /// Display a local notification
  void displayLocalNotification({
    required int id,
    required String title,
    required String body,
    required Map<String, dynamic> data,
  }) async {
    await flutterLocalNotificationsPlugin.show(
      id,
      title,
      body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: androidNotificationChannel.description,
          importance: Importance.high,
          priority: Priority.high,
          icon: '@mipmap/ic_launcher',
        ),
      ),
      payload: jsonEncode(data),
    );
  }

  /// Handle notification redirection based on type
  void handleNotificationRedirection(Map<String, dynamic> data) {
    int type = data['type'] ?? 0;

    switch (type) {
      case 1: // Admin Notification
        Get.toNamed(Routes.HOME);
        break;
      case 2: // Affirmation Reminder
        Get.toNamed(Routes.HOME);
        break;
      case 3: // Journal Reminder
        Get.toNamed(Routes.Journal_Home);
        break;
      default:
        log('Unknown notification type: $type');
    }
  }

  /// Listen for notifications
  void notificationListeners() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      log("Foreground notification received: ${message.data}");
      displayLocalNotification(
        id: message.hashCode,
        title: message.notification?.title ?? "Notification",
        body: message.notification?.body ?? "You have a new notification.",
        data: message.data,
      );
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
      log("Notification opened: ${message.data}");
      handleNotificationRedirection(message.data);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) async {
      if (message != null) {
        log("App launched from notification: ${message.data}");
        handleNotificationRedirection(message.data);
      }
    });
  }
}