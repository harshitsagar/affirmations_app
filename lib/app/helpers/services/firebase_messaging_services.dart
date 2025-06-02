import 'dart:convert';
import 'dart:developer';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import '../../routes/app_pages.dart';

class NotificationUtils {
  static const notificationChannelId = "com.affirmations.app";
  static const notificationChannelName ="affirmations";
  static const notificationChannelDescription = "Channel to show the app notifications.";

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

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
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');

    log("initializationSettingsAndroid----------------initializationSettingsAndroid");
    initializationSettingsAndroid =
    const AndroidInitializationSettings('launcher_icon');

    DarwinInitializationSettings initializationSettingsIOS =
    DarwinInitializationSettings(
      defaultPresentAlert: true,
      defaultPresentBadge: true,
      defaultPresentSound: true,
      //  onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (NotificationResponse? payload) async {
        if (payload != null) {
          final Map<String, dynamic> data = jsonDecode(payload.payload!);
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
      enableVibration: true,
      showBadge: true,
    );

    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidNotificationChannel);

    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
    await FirebaseMessaging.instance.setAutoInitEnabled(true);

    //this function listen all notification
    notificationListeners();

  }

  void onDidReceiveLocalNotification(
      int? id,
      String? title,
      String? body,
      String? payload,
      ) async {
    // display a dialog with the notification details, tap ok to go to another page
    showDialog(
      context: context!,
      builder: (BuildContext context) => CupertinoAlertDialog(
        title: Text(title!),
        content: Text(body!),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: const Text("ok"),
            onPressed: () async {
              Navigator.of(context, rootNavigator: true).pop();
              // await Get.toNamed(NotificationScreen.routeName);
            },
          )
        ],
      ),
    );
  }

  BuildContext? context;

  // Future<void> handleNewNotification(RemoteMessage message) async {
  //   log("firebase messageing listen 211 : ${message.data}");
  //   // display the notification manually
  //   final data = message.data;
  //
  //   if (GetPlatform.isAndroid) {
  //     final bottomNavigationBarController =
  //     Get.find<BottomNavigationController>();
  //     bottomNavigationBarController.getNotificationCount();
  //     if (Get.isRegistered<NotificationController>()) {
  //       var notificationController = Get.find<NotificationController>();
  //       notificationController.fetchNotifications(pageKey: 1);
  //       notificationController.update();
  //     }
  //     // the push is from foreground
  //     // here we need to manually display the notification
  //     displayLocalNotification(
  //       id: message.hashCode,
  //       title: data['title'],
  //       body: message.notification?.body,
  //       data: message.data,
  //     );
  //     return;
  //   }
  // }

  bool notificationUnread = true;

  Future<void> handleAppLunchLocalNotification() async {
    final NotificationAppLaunchDetails? notificationAppLaunchDetails =
    await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
    final didNotificationLaunchApp =
        notificationAppLaunchDetails?.didNotificationLaunchApp ?? false;

    if (didNotificationLaunchApp && notificationUnread) {
      if (notificationAppLaunchDetails!.notificationResponse?.payload != null) {
        notificationUnread = false;
      }
    }
  }



  /// Display a local notification
  void displayLocalNotification({
    required int id,
    required String title,
    required String body,
    Map<String, dynamic> data = const {},
  }) async {
    if (kIsWeb) {
    } else {
      await flutterLocalNotificationsPlugin.show(
        id,
        title,
        body,
        NotificationDetails(
          android: AndroidNotificationDetails(
            androidNotificationChannel?.id ?? notificationChannelId,
            androidNotificationChannel?.name ?? notificationChannelName,
            channelDescription:
            androidNotificationChannel?.description ?? 'affirmations',
            ticker: title,
            importance: Importance.high,
            priority: Priority.high,
            icon: '@mipmap/ic_launcher',
          ),
        ),
        payload: data.isNotEmpty ? jsonEncode(data) : null,
      );
    }
  }
  /// Handle notification redirection based on type
  void handleNotificationRedirection(Map<String, dynamic> data) {
    int type = int.tryParse(data['type'].toString()) ?? 0;

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

      // Safely parse title/body
      String title = message.notification?.title ??
          message.data['title'] ?? 'Notification';
      String body = message.notification?.body ??
          message.data['text'] ?? 'You have a new notification.';

      displayLocalNotification(
        id: message.hashCode,
        title: title,
        body: body,
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