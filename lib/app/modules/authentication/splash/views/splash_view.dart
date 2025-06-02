import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {

    Get.put(SplashController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //       image: AssetImage(bgImage),
        //       fit: BoxFit.cover
        //   )
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [

            SizedBox(
              height: 264.h,
              width: 264.w,
              child: Image.asset(
                  splashLogo,
                  fit: BoxFit.contain,
              ),
            ),

            Center(
              child: Text(
                "Affirmations",
                style: TextStyle(
                  fontSize: 30.sp,
                  fontFamily: "LucidaHandwriting",
                  color: Colors.black,
                ),
              ),
            ),

          ],
        ),
      )
    );
  }
}
