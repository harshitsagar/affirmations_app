import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

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
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(
              height: 320.51,
              // width: 313.75,
              child: Image.asset(
                  splashLogo,
                  fit: BoxFit.contain,
              ),
            ),

            SizedBox(height: 16,),

            Center(
              child: Text(
                "Affirmations",
                style: TextStyle(
                  fontSize: 32,
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
