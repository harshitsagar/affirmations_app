import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import '../controllers/journal_controller.dart';

class JournalReminder extends GetView<JournalController> {
  const JournalReminder({super.key});

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
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
          child: Column(
            children: [
              const CustomAppBar(title: ""),
              SizedBox(height: 30.h),
              // Title
              Text(
                'Set journal writing reminders',
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 32.h),

              // Time Selection Container
              Obx(() {

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

                return Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.6),
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  padding: EdgeInsets.all(20.r),
                  child: Column(
                    children: [
                      _buildTimeSelector(
                        context,
                        'Start At',
                        "am",
                        controller.startTime,
                            () => controller.selectStartTime(context),
                        isAM: true,
                      ),
                      SizedBox(height: 25.h),
                      _buildTimeSelector(
                        context,
                        'End At',
                        "pm",
                        controller.endTime,
                            () => controller.selectEndTime(context),
                        isAM: false,
                      ),
                    ],
                  ),
                );

              }),

              const Spacer(),
              // Next Button
              Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.navigateToHearAboutScreen,
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

  Widget _buildTimeSelector(
      BuildContext context,
      String label,
      String period_name,
      Rx<TimeOfDay> time,
      VoidCallback onTap, {
        required bool isAM,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: onTap,
          child: Obx(() {
            final isDefaultTime = time.value.hour == (isAM ? 0 : 12) &&
                time.value.minute == 0;
            final hour = isDefaultTime
                ? '00'
                : (time.value.hour > 12
                ? (time.value.hour - 12).toString().padLeft(2, '0')
                : time.value.hour.toString().padLeft(2, '0'));
            final minute = time.value.minute.toString().padLeft(2, '0');
            final period = isDefaultTime
                ? period_name
                : (time.value.hour < 12 ? 'am' : 'pm');

            return Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$hour:$minute ',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: isDefaultTime
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: period,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    clockIcon,
                    color: Colors.black,
                    width: 24.w,
                    height: 24.w,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

  /*
  Widget _buildTimeSelector(
      BuildContext context,
      String label,
      String period_name,
      Rx<TimeOfDay> time,
      VoidCallback onTap, {
        required bool isAM,
      }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: onTap,
          child: Obx(() {
            final hour = time.value.hour == 0 || time.value.hour == 12
                ? '12'
                : (time.value.hour % 12).toString().padLeft(2, '0');
            final minute = time.value.minute.toString().padLeft(2, '0');
            final period = time.value.hour < 12 ? 'am' : 'pm';

            return Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$hour:$minute ',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: period,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    clockIcon,
                    color: Colors.black,
                    width: 24.w,
                    height: 24.w,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
   */

}