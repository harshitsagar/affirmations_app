import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../controllers/filter_controller.dart';

class FilterView extends GetView<FilterController> {
  const FilterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFFDF9F8),
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h, bottom: 40.h),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          GestureDetector(
            onTap: () => Get.back(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [

                Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                  size: 20.sp,
                ),

                Text(
                  'Back',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 40.h),

          Text(
            'Date Range',
            style: GoogleFonts.inter(
              fontSize: 20.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            'Select the date range for which you want to see the mood chart.',
            style: GoogleFonts.inter(
              fontSize: 14.sp,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 24.h),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              Flexible(
                child: Obx(() => _buildDateField(
                  'From',
                  controller.fromDate.value,
                      () => controller.selectFromDate(context),
                )),
              ),

              SizedBox(width: 10.w),

              Flexible(
                child: Obx(() => _buildDateField(
                  'To',
                  controller.toDate.value,
                      () => controller.selectToDate(context),
                )),
              ),

            ],
          ),

          SizedBox(height: 120.h),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => controller.applyFilters(),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30.r),
                ),
              ),
              child: Text(
                'Apply',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          SizedBox(height: 4.h),

          Align(
            alignment: Alignment.center,
            child: TextButton(
              onPressed: () => Get.back(),
              style: TextButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 5.h),
                textStyle: const TextStyle(decoration: TextDecoration.underline),
              ),
              child: Text(
                'Cancel',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),

        ],
      ),
    );
  }

  Widget _buildDateField(String label, DateTime? date, VoidCallback onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey[300]!),
              borderRadius: BorderRadius.circular(24.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  date != null
                      ? DateFormat('dd MMM yyyy').format(date)
                      : label,
                  style: GoogleFonts.inter(
                    fontSize: 14.sp,
                    color: date != null ? Colors.black : Colors.grey,
                  ),
                ),
                SvgPicture.asset(
                  datePickerIcon,
                  width: 20.w,
                  height: 20.h,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}