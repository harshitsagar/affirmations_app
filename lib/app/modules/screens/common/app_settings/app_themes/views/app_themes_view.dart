import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/app_themes_controller.dart';

class AppThemesView extends GetView<AppThemesController> {
  const AppThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        // final currentPreviewTheme = controller.selectedTheme.value;
        final currentPreviewTheme =
            controller.selectedTheme.value ?? ThemeService.getDefaultTheme();
        return Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: currentPreviewTheme != null
          //     ? BoxDecoration(
          //   gradient: LinearGradient(
          //     colors: currentPreviewTheme.backgroundGradient!
          //         .map((color) => Color(int.parse(color.replaceFirst('#', '0xFF'))))
          //         .toList(),
          //     begin: Alignment.topLeft,
          //     end: Alignment.bottomRight,
          //   ),
          // ) : ThemeService.getBackgroundDecoration(),
          decoration:
              currentPreviewTheme.aspect == 'default'
                  ? BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(bgImage),
                      fit: BoxFit.cover,
                    ),
                  )
                  : BoxDecoration(
                    gradient: LinearGradient(
                      colors:
                          currentPreviewTheme.backgroundGradient!
                              .map(
                                (color) => Color(
                                  int.parse(color.replaceFirst('#', '0xFF')),
                                ),
                              )
                              .toList(),
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Custom App Bar with back button
                  CustomAppBar(title: "App Theme"),

                  SizedBox(height: 30.h),

                  // Title Text
                  Text(
                    "Let's choose your theme",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Theme Grid
                  Expanded(
                    child: Obx(() {
                      if (controller.loadingStatus.value ==
                          LoadingStatus.loading) {
                        return Center(
                          child:
                              Platform.isAndroid
                                  ? CircularProgressIndicator(
                                    strokeWidth: 4.w,
                                    color: AppColors.black,
                                  )
                                  : CupertinoActivityIndicator(
                                    color: AppColors.black,
                                    radius: 20.r,
                                  ),
                        );
                      }

                      return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio: 0.62,
                        ),
                        itemCount: controller.availableThemes.length,
                        itemBuilder: (context, index) {
                          final theme = controller.availableThemes[index];
                          bool isSelected =
                              controller.selectedTheme.value?.sId == theme.sId;
                          bool isLocked =
                              theme.aspect == 'premium' &&
                              !controller.isPremium.value;

                          return GestureDetector(
                            onTap: () {
                              controller.selectTheme(theme);
                              // Get.changeTheme(ThemeService.getThemeData(theme));
                              ThemeService.applyTheme(theme);

                              Get.forceAppUpdate();
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Theme Container
                                Container(
                                  decoration:
                                      theme.aspect == 'default'
                                          ? BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            image: DecorationImage(
                                              image: AssetImage(bgImage),
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                          : BoxDecoration(
                                            borderRadius: BorderRadius.circular(
                                              12.r,
                                            ),
                                            gradient: LinearGradient(
                                              colors:
                                                  theme.backgroundGradient!
                                                      .map(
                                                        (color) => Color(
                                                          int.parse(
                                                            color.replaceFirst(
                                                              '#',
                                                              '0xFF',
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                      .toList(),
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                  child: Center(
                                    child: Text(
                                      "Aa",
                                      style: GoogleFonts.inter(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ),

                                // Selection indicator
                                if (isSelected)
                                  Positioned(
                                    top: 8.h,
                                    right: 8.w,
                                    child: Image.asset(
                                      greenTickIcon,
                                      width: 30.w,
                                      height: 30.h,
                                    ),
                                  ),

                                // Lock overlay for locked themes
                                if (isLocked)
                                  Positioned(
                                    top: -3.h,
                                    right: 0.w,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                          12.r,
                                        ),
                                      ),
                                      child: Center(
                                        child: Image.asset(
                                          lockIcon,
                                          width: 48.w,
                                          height: 48.h,
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          );
                        },
                      );
                    }),
                  ),

                  // Save Button
                  Padding(
                    padding: EdgeInsets.only(bottom: 8.h, top: 8.h),
                    child: ElevatedButton(
                      onPressed: controller.saveTheme,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        minimumSize: Size(double.infinity, 45.h),
                      ),
                      child: Text(
                        "Save",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}

/*
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/app_themes_controller.dart';

class AppThemesView extends GetView<AppThemesController> {
  const AppThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx((){

        final currentTheme = controller.selectedTheme.value;
        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: ThemeService.getBackgroundDecoration(currentTheme),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [

                  // Custom App Bar with back button
                  CustomAppBar(title: "App Theme"),

                  SizedBox(height: 30.h),

                  // Title Text
                  Text(
                    "Let's choose your theme",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 32.h),

                  // Theme Grid
                  Expanded(
                    child: GetBuilder<AppThemesController>(
                      builder: (controller) {
                        return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            crossAxisSpacing: 10.w,
                            mainAxisSpacing: 10.h,
                            childAspectRatio: 0.62,
                          ),
                          itemCount: controller.themeImages.length,
                          itemBuilder: (context, index) {
                            bool isSelected = controller.selectedTheme.value == index;
                            bool isLocked = !controller.isPremium.value &&
                                controller.lockedThemes[index];

                            return GestureDetector(
                              onTap: () => controller.selectTheme(index),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Theme Container
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                      image: DecorationImage(
                                        image: AssetImage(controller.themeImages[index]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Aa",
                                        style: GoogleFonts.inter(
                                          fontSize: 25.sp,
                                          fontWeight: FontWeight.w500,
                                          color: controller.themeTextColors[index],
                                        ),
                                      ),
                                    ),
                                  ),

                                  // Selection indicator
                                  if (isSelected)
                                    Positioned(
                                      top: 8.h,
                                      right: 8.w,
                                      child: Image.asset(
                                        greenTickIcon,
                                        width: 30.w,
                                        height: 30.h,
                                      ),
                                    ),

                                  // Lock overlay for locked themes
                                  if (isLocked)
                                    Positioned(
                                      top: -3.h,
                                      right: 0.w,
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12.r),
                                        ),
                                        child: Center(
                                          child: Image.asset(
                                            lockIcon,
                                            width: 48.w,
                                            height: 48.h,
                                          ),
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),

                  // Save Button
                  Padding(
                    padding: EdgeInsets.only(top: 16.h),
                    child: ElevatedButton(
                      onPressed: controller.saveTheme,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        minimumSize: Size(double.infinity, 45.h),
                      ),
                      child: Text(
                        "Save",
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );

      }),
    );
  }
}

 */
