import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/reminders_controller.dart';

class RemindersView extends GetView<RemindersController> {
  const RemindersView({super.key});

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => RemindersController());

    return Scaffold(

      body: Obx(() {

        final controller = Get.find<RemindersController>();

        if (controller.loadingStatus.value == LoadingStatus.loading) {
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
          // decoration: const BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(bgImage2), // Replace with your actual image path
          //     fit: BoxFit.cover,
          //   ),
          // ),
          decoration: ThemeService.getBackgroundDecoration(),
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 50.h),
            child: SingleChildScrollView(
              child: Column(
                children: [

                  const CustomAppBar(title: "Reminders"),

                  SizedBox(height: 30.h),

                  // Title
                  Text(
                    'Affirmations Reminders',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Affirmation Count
                  Obx(() => Container(
                    width: double.infinity,
                    height: 50.h,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: SvgPicture.asset(
                              minusIcon, // Replace with your actual icon path
                              width: 24.w,
                              height: 24.h,
                            ),
                            onPressed: controller.decrementAffirmations,
                            padding: EdgeInsets.zero,
                          ),
                          Text(
                            controller.affirmationCount.value.toString(),
                            style: GoogleFonts.inter(
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          IconButton(
                            icon: SvgPicture.asset(
                              plusIcon, // Replace with your actual icon path
                              width: 24.w,
                              height: 24.h,
                            ),
                            onPressed: controller.incrementAffirmations,
                            padding: EdgeInsets.zero,
                          ),
                        ],
                      ),
                    ),
                  )),
                  SizedBox(height: 16.h),

                  // Affirmation Time Selection
                  _buildTimeSelectionContainer(
                    context,
                    'Start At',
                    controller.affirmationStartTime,
                        () => controller.selectAffirmationStartTime(context),
                    'End At',
                    controller.affirmationEndTime,
                        () => controller.selectAffirmationEndTime(context),
                  ),
                  SizedBox(height: 30.h),

                  // Journal Reminder Section
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "Journal Reminders",
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Add Entry Reminder
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Add Entry Reminder',
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                        Obx(() => Transform.scale(
                          scale: 0.9,
                          child: Switch(
                            value: controller.isJournalReminderActive.value,
                            onChanged: (_) => controller.toggleJournalReminder(),
                            activeColor: Colors.white, // Thumb color when active
                            activeTrackColor: const Color(0xFF84cc16), // Green track
                            inactiveThumbColor: Colors.white, // Pure white thumb (no border look)
                            inactiveTrackColor: const Color(0xFFE8E1E1), // Light gray background
                            splashRadius: 0.0,
                            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                        )),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.h),

                  // Journal Time Selection
                  _buildTimeSelectionContainer(
                    context,
                    'Start At',
                    controller.journalStartTime,
                        () => controller.selectJournalStartTime(context),
                    'End At',
                    controller.journalEndTime,
                        () => controller.selectJournalEndTime(context),
                  ),
                  SizedBox(height: 40.h),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveReminders,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Save',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        );

      }),
    );
  }

  Widget _buildTimeSelectionContainer(
      BuildContext context,
      String startLabel,
      Rx<TimeOfDay> startTime,
      VoidCallback onStartTimeTap,
      String endLabel,
      Rx<TimeOfDay> endTime,
      VoidCallback onEndTimeTap,
      ) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        children: [
          _buildTimeSelector(
            context,
            startLabel,
            startTime,
            onStartTimeTap,
          ),
          SizedBox(height: 20.h),
          _buildTimeSelector(
            context,
            endLabel,
            endTime,
            onEndTimeTap,
          ),
        ],
      ),
    );
  }

  Widget _buildTimeSelector(
      BuildContext context,
      String label,
      Rx<TimeOfDay> time,
      VoidCallback onTap,
      ) {
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
            final hour = time.value.hour > 12
                ? (time.value.hour - 12).toString().padLeft(2, '0')
                : time.value.hour.toString().padLeft(2, '0');
            final minute = time.value.minute.toString().padLeft(2, '0');
            final period = time.value.hour < 12 ? 'am' : 'pm';

            return Container(
              height: 50.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '$hour:$minute $period',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const Icon(Icons.access_time, color: Colors.black),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}