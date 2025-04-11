import 'dart:ui';
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/add_entry_controller.dart';

class AddEntryView extends GetView<AddEntryController> {
  const AddEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // This makes it appear like a bottom sheet with rounded corners
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Padding(
          padding: EdgeInsets.only(left: 18.w, right: 18.w, bottom: 20.h, top: 15.h),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The gray bar at the top
              Container(
                width: 60.w,
                height: 5.h,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10.r),
                ),
              ),

              SizedBox(height: 40.h),

              Image.asset(
                  addEntryImage,
                  height: 154.h,
                  width: 182.h
              ),

              SizedBox(height: 24.h),

              Text(
                "How do you feel right now?",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                ),
              ),

              SizedBox(height: 16.h),

              Text(
                "Take a moment to check in with yourself.\nAdd an entry into Journal.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),

              SizedBox(height: 40.h),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.onAddEntry();
                    Get.back(); // Close sheet
                    Get.toNamed('/journal');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.r),
                    ),
                  ),
                  child: Text(
                    'Add Entry',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              TextButton(
                onPressed: () {
                  controller.onDontAskMeAgain();
                  Get.back();
                },
                child: Text(
                  "Don’t Ask Me Again",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
