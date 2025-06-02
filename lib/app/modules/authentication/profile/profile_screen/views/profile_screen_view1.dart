// profile_screen_view1.dart
import 'dart:io';

import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/modules/authentication/profile/profile_screen/views/profile_screen_view2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';
import '../controllers/profile_screen_controller.dart';

class ProfileScreenView1 extends GetView<ProfileScreenController> {
  const ProfileScreenView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {

        if (controller.isLoading.value) {
          return Center(
            child: Platform.isAndroid
                ? CircularProgressIndicator(
              strokeWidth: 4.w,
              color: Colors.black,
            )
                : CupertinoActivityIndicator(
              color: Colors.black,
              radius: 20.r,
            ),
          );
        }

        return Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImage),
              fit: BoxFit.cover,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Skip button
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: EdgeInsets.only(top: 60.h),
                    child: TextButton(
                      onPressed: () {
                        controller.selectAgeGroup("");
                        Get.to(() => ProfileScreenView2());
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
                  ),
                ),

                // Title
                Padding(
                  padding: EdgeInsets.only(top: 20.h),
                  child: Text(
                    'How old are you?',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 30.h),

                // Age options
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        _buildAgeOption('18 or Under'),
                        SizedBox(height: 15.h),
                        _buildAgeOption('19 - 24'),
                        SizedBox(height: 15.h),
                        _buildAgeOption('25 - 34'),
                        SizedBox(height: 15.h),
                        _buildAgeOption('35 - 44'),
                        SizedBox(height: 15.h),
                        _buildAgeOption('45 - 54'),
                        SizedBox(height: 15.h),
                        _buildAgeOption('55 - 64'),
                        SizedBox(height: 15.h),
                        _buildAgeOption('65 or Older'),
                      ],
                    ),
                  ),
                ),

                // Next button
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (controller.selectedAgeGroup.isNotEmpty) {
                          await controller.updateProfile();
                          Get.to(() => const ProfileScreenView2());
                        }
                        else{
                          AppConstants.showSnackbar(
                              headText: 'Note',
                              content: 'Please select an age group',

                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
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
        );

      }),
    );
  }

  Widget _buildAgeOption(String ageGroup) {
    return SizedBox(
      height: 38.h,
      child: Obx(() => GestureDetector(
        onTap: () {
          if (controller.selectedAgeGroup.value == ageGroup) {
            controller.selectAgeGroup('');
          } else {
            controller.selectAgeGroup(ageGroup);
          }
        },
        child: Container(
          height: 56.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30.r),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ageGroup,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  controller.selectedAgeGroup.value == ageGroup
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