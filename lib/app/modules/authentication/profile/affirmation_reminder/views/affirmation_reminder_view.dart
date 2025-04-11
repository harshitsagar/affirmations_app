import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../data/components/images_path.dart';
import '../controllers/affirmation_reminder_controller.dart';

class AffirmationReminderView extends GetView<AffirmationReminderController> {
  const AffirmationReminderView({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(AffirmationReminderController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 60.h),
          child: Column(
            children: [
              const CustomAppBar(title: ""),
              SizedBox(height: 30.h),

              // Title Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Text(
                      'Choose when to receive your affirmation reminders',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Reading multiple affirmations a day will help you achieve your goals faster',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),

              // Affirmation Counter
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
                          minusIcon,
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
                          plusIcon,
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

              SizedBox(height: 30.h),

              // Time Selection Container
              Container(
                width: double.infinity,
                height: 208.h,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 16.h, bottom: 16.h),
                child: Column(
                  children: [
                    _buildTimeSelector(
                      context,
                      'Start At',
                      "am",
                      controller.startTime,
                          () => controller.selectStartTime(context),
                    ),
                    SizedBox(height: 20.h),
                    _buildTimeSelector(
                      context,
                      'End At',
                      "pm",
                      controller.endTime,
                          () => controller.selectEndTime(context),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Submit Button
              Padding(
                padding: EdgeInsets.only(bottom: 40.h),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.savePreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      "Let's Do This!",
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
      ),
    );
  }

  Widget _buildTimeSelector(
      BuildContext context,
      String label,
      String period_name,
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
            final isDefaultTime = time.value.hour == 0 && time.value.minute == 0;
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
              height: 44.h,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16.r),
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '$hour:$minute',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: isDefaultTime
                              ? const Color(0xFFA9A9A9)
                              : Colors.black,
                        ),
                      ),
                      if (period.isNotEmpty) ...[
                        SizedBox(width: 4.w),
                        Text(
                          period,
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ],
                  ),
                  Icon(Icons.access_time),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}