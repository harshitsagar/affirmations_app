import 'package:affirmations_app/app/modules/authentication/profile/affirmation_reminder/views/affirmation_reminder_view.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../data/components/images_path.dart';
import '../controllers/affirmations_controller.dart';

class AffirmationsView extends GetView<AffirmationsController> {
  const AffirmationsView({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.put(AffirmationsController());

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
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  title: "",
                  onBackPressed: () => Get.off(() => AffirmationReminderView()),
                ),
                SizedBox(height: 20.h),

                // Title Section
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.h),
                  child: Text(
                    'On which area you want to work though affirmations?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  'Select minimum of 3 areas',
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 20.h),

                // Areas List
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: controller.areas.length,
                    itemBuilder: (context, index) {
                      final area = controller.areas[index];
                      return Obx(() {
                        final isSelected = controller.selectedAreas.contains(area);
                        return _buildAreaItem(area, isSelected);
                      });
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // Next Button
                Padding(
                  padding: EdgeInsets.only(bottom: 8.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (controller.selectedAreas.length >= 3) {
                          controller.navigateToThemeScreen();
                        } else {
                          Get.snackbar(
                            'Selection Required',
                            'Please select at least 3 areas',
                            snackPosition: SnackPosition.TOP,
                            duration: const Duration(seconds: 2),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 16.h),
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
        ),
      ),
    );
  }

  Widget _buildAreaItem(String area, bool isSelected) {
    final controller = Get.find<AffirmationsController>();
    return SizedBox(
      width: double.infinity,
      height: 55.h,
      child: Padding(
        padding: EdgeInsets.only(bottom: 16.h),
        child: GestureDetector(
          onTap: () => controller.toggleAreaSelection(area),
          child: Container(
            height: 56.h,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
              borderRadius: BorderRadius.circular(30.r),
            ),
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  area,
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SvgPicture.asset(
                  isSelected ? checkedIcon : uncheckedIcon,
                  width: 14.w,
                  height: 14.h,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
