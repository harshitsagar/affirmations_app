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
import '../controllers/themes_controller.dart';

class ThemesView extends GetView<ThemesController> {
  const ThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThemesController());

    return Scaffold(
      body: Obx(() {
        final currentPreviewTheme =
            controller.selectedTheme.value ?? ThemeService.getDefaultTheme();
        return Container(
          width: double.infinity,
          height: double.infinity,
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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Back Button
                Padding(
                  padding: EdgeInsets.only(left: 20.w, top: 10.h),
                  child: CustomAppBar(title: ""),
                ),

                SizedBox(height: 30.h),

                // Title Text
                Text(
                  "Let's choose your theme",
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 32.h),

                // Theme Options
                Obx(() {
                  if (controller.loadingStatus.value == LoadingStatus.loading) {
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

                  return Expanded(
                    flex: 9,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3, // 3 items per row
                          crossAxisSpacing: 10.w,
                          mainAxisSpacing: 10.h,
                          childAspectRatio:
                              0.6, // Adjust this for item proportions
                        ),
                        itemCount: controller.availableThemes.length,
                        itemBuilder: (context, index) {
                          final theme = controller.availableThemes[index];
                          bool isSelected =
                              controller.selectedTheme.value?.sId == theme.sId;

                          return GestureDetector(
                            onTap: () {
                              controller.selectTheme(theme);
                              ThemeService.applyTheme(theme);
                            },
                            child: Container(
                              height: 160.h,
                              width: 105.w,
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
                              child: Stack(
                                children: [
                                  Center(
                                    child: Text(
                                      "Aa",
                                      style: GoogleFonts.inter(
                                        fontSize: 25.sp,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: 5.h,
                                      right: 8.w,
                                      child: Image.asset(
                                        greenTickIcon,
                                        height: 30.h,
                                        width: 30.w,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),

                const Spacer(),

                // Next Button
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 10.h,
                  ),
                  child: ElevatedButton(
                    onPressed: () async {
                      await controller.saveSelectedTheme();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                      minimumSize: Size(double.infinity, 45.h),
                    ),
                    child: Text(
                      "Next",
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
        );
      }),
    );
  }
}
