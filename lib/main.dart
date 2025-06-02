import 'dart:developer';

import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/modules/authentication/profile/themes/controllers/themes_controller.dart';
import 'package:affirmations_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/helpers/services/firebase_messaging_services.dart';
import 'app/helpers/services/local_storage.dart';
import 'app/routes/app_pages.dart';
import 'package:permission_handler/permission_handler.dart';

// GetIt sl = GetIt.instance;

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  log('Handling a background message ${message.messageId}');
  if (message.data["badge"] != null) {
    // int badgeCount = int.parse(message.data["badge"]);
    // log(badgeCount.toString());
  }
}

void main() async {

  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  // Initialize Firebase with platform-specific options
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register the background message handler for FCM
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  await requestNotificationPermission();


  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();


  // Initialize notifications and retrieve the FCM token
  await NotificationUtils().init().then((value) {

    Future.delayed(
      const Duration(seconds: 2), // Delay token retrieval
          () {
         getAndSaveToken(); // Retrieve and save the FCM token
      },
    );
  }
  );

  // Initialize local storage
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
}

Future<void> requestNotificationPermission() async {
  final status = await Permission.notification.status;
  log('Notification Permission Status: $status');
  if (status.isDenied || status.isPermanentlyDenied) {
    final result = await Permission.notification.request();
    log('Notification Permission Requested: $result');
  }
}

Future getAndSaveToken() async {
  String? token = await FirebaseMessaging.instance.getToken();
  LocalStorage.setFCMToken(token!);
  log("fcm token================== # ${LocalStorage.getFCMToken()}");
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    final currentTheme = ThemesController.getCurrentTheme();
    final MediaQueryData data = MediaQuery.of(context);

    return MediaQuery(
      data: data.copyWith(
        textScaler: const TextScaler.linear(1), // Maintain consistent text scaling
      ),
      child: ScreenUtilInit(
        designSize: const Size(360, 690), // Standard design size for responsiveness
        splitScreenMode: true, // Better multi-window support
        minTextAdapt: true, // Adapt text for smaller screens
        builder: (context, child) {
          return GetMaterialApp(
            debugShowCheckedModeBanner: false,
            title: "Affirmations App",
            theme: ThemeService.getThemeData(currentTheme),
            initialRoute: AppPages.INITIAL,
            getPages: AppPages.routes,
          );
        },
      ),
    );
  }
}