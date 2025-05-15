import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2), // from your sample
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
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
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Custom AppBar....
                  CustomAppBar(title: "Settings"),

                  SizedBox(height: 30.h),

                  // Try Premium Now Container....
                  Container(
                    width: double.infinity,
                    height: 104.h,
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: [
                          Color(0xffB4A4F9),
                          Color(0xFFFFCCEA)
                        ],
                      ),
                    ),
                    child: Stack(
                      children: [

                        Padding(
                          padding: EdgeInsets.only(left: 5.w, top: 15.h),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 5.h,
                            children: [
                              Text(
                                'Try Premium Now',
                                style: GoogleFonts.inter(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Removes Ads & unlock all themes',
                                style: GoogleFonts.inter(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          right: 5.w,
                          child: Image.asset(
                            diamondIcon,
                            width: 70.w,
                            height: 70.h,
                          ),
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 34.h),

                  // About You Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'About You',
                        style: GoogleFonts.inter(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w700,
                          color: Colors.black,
                        ),
                      ),
                      GestureDetector(
                          onTap: () => Get.toNamed(Routes.ABOUT_EDIT),
                          child: Image.asset(editIcon, height: 24.h, width: 24.w)
                      ), // your icon here
                    ],
                  ),

                  SizedBox(height: 16.h),

                  // User Info Container
                  Obx(() => Container(
                    padding: EdgeInsets.only(left: 24.w, right: 24.w, top: 16.h, bottom: 16.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      children: [
                        _buildUserInfoRow('Name', controller.name.value.isNotEmpty ? controller.name.value : "--"),
                        Divider(color: Color(0xFFF3F4F6), height: 16.h),
                        _buildUserInfoRow('Email', controller.email.value.isNotEmpty ? controller.email.value : "--"),
                        Divider(color: Color(0xFFF3F4F6), height: 16.h),
                        _buildUserInfoRow('Age', controller.age.value.isNotEmpty ? controller.age.value : "--"),
                        Divider(color: Color(0xFFF3F4F6), height: 16.h),
                        _buildUserInfoRow('Gender', controller.gender.value.isNotEmpty ? controller.gender.value : "--"),
                      ],
                    ),
                  )),

                  SizedBox(height: 32.h),

                  // Settings Header
                  Text(
                    'Settings',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Settings Options Container
                  Container(
                    padding: EdgeInsets.only(left: 5.w, top: 5.h),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        _buildSettingItem(affirmationTypesIcon, 'Affirmations Types'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(reminderIcon, 'Reminders',),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(appthemeIcon, 'App Theme'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(sharingIcon, 'Refer a Friend'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(reviewIcon, 'Leave us a Review'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(aboutUsIcon, 'About Us'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(termsConditionsIcon, 'Terms & Conditions'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(privacyPolicyIcon, 'Privacy Policy'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(contactAdminIcon, 'Contact Admin'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(faqIcon, 'FAQs'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(logoutIcon, 'Logout'),
                        Divider(color: Color(0xFFF3F4F6), height: 10.h, thickness: 1,),
                        _buildSettingItem(deleteIcon, 'Delete'),

                        SizedBox(height: 5.h),

                      ],
                    ),
                  ),

                  SizedBox(height: 10.h),

                  Center(
                    child: Text(
                      //DEV Server

                      //android
                      'Dev v1.0 (1.0.0)',

                      // Stage Server

                      //android
                      // 'Stage v3.0 (1.0.0)',

                      //Production Server

                      // 'v1.0 (1.0.0)',
                      style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                        fontSize: 16.sp,
                        color: AppColors.black.withOpacity(0.5),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ],
              ),
            );

          }),
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 6.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String image, String title) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(horizontal: 12.w),

      leading: Image.asset(image, height: 24.h, width: 24.w,),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      onTap: () => controller.handleSettingTap(title),
    );
  }

}
