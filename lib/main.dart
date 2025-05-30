import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/modules/authentication/profile/themes/controllers/themes_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'app/helpers/services/firebase_messaging_services.dart';
import 'app/routes/app_pages.dart';

void main() async {

  // Initialize Flutter bindings
  WidgetsFlutterBinding.ensureInitialized();


  // final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  // FlutterLocalNotificationsPlugin();
  //
  //
  // // Initialize notifications and retrieve the FCM token
  // await NotificationUtils().init().then((value) {
  //
  //   Future.delayed(
  //     const Duration(seconds: 2), // Delay token retrieval
  //         () {
  //       // getAndSaveToken(); // Retrieve and save the FCM token
  //     },
  //   );
  // }
  //
  //     );




  // Initialize local storage
  await GetStorage.init();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown],
  );
  runApp(const MyApp());
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