import 'dart:io';

import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreenView2 extends GetView<ProfileScreenController> {
  const ProfileScreenView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(bgImage),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child:
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Header with back and skip buttons
              Padding(
                padding: EdgeInsets.only(top: 60.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back(); // Navigates back to previous screen
                      },
                      iconSize: 24.sp,
                    ),
                    // Skip button
                    TextButton(
                      onPressed: () {
                        controller.selectGender(''); // Clear selection
                        Get.toNamed(Routes.AFFIRMATION_REMINDER);
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Title
              Padding(
                padding: EdgeInsets.only(top: 40.h),
                child: Text(
                  'What best represents you?',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 32.h),

              Expanded(
                  child: Obx(() {

                    if (controller.loadingStatus.value == LoadingStatus.loading) {
                      return Center(
                        child: Platform.isAndroid
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

                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          _buildGenderOption('Female'),
                          SizedBox(height: 20.h),
                          _buildGenderOption('Male'),
                          SizedBox(height: 20.h),
                          _buildGenderOption('Non-Binary'),
                          SizedBox(height: 20.h),
                          _buildGenderOption('Prefer not to say'),
                        ],
                      ),
                    );

                  },
                  )),

              // Next button
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
                      if (controller.selectedGender.isNotEmpty) {
                        await controller.updateProfile();
                        Get.toNamed(Routes.AFFIRMATION_REMINDER);
                      }
                      else{
                        Get.snackbar(
                          'Note',
                          'Please select gender',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.transparent,
                          colorText: Colors.black,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'Next',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }

  Widget _buildGenderOption(String gender) {
    return SizedBox(
      height: 45.h,
      child: Obx(() => GestureDetector(
        onTap: () {
          if (controller.selectedGender.value == gender) {
            controller.selectGender('');
          } else {
            controller.selectGender(gender);
          }
        },
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Padding(
            padding: EdgeInsets.only(top: 12.h, bottom: 12.h, left: 20.w, right: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gender,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  controller.selectedGender.value == gender
                      ? selectedIcon
                      : unselectedIcon,
                  width: 15.w,
                  height: 15.h,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

}