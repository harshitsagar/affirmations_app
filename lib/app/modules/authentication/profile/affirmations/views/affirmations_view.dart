import 'dart:io';

import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/modules/authentication/profile/affirmation_reminder/views/affirmation_reminder_view.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
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
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  title: "",
                  onBackPressed: () => Get.off(() => AffirmationReminderView()),
                ),
                SizedBox(height: 20.h),

                // Title Section
                // Padding(
                //   padding: EdgeInsets.symmetric(horizontal: 8.h),
                  Text(
                    'On which area you want  to work through affirmations?',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
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

                    return Column(
                      children: [
                        Expanded(
                          child: ListView.separated(
                            itemCount: controller.affirmationTypes.length,
                            separatorBuilder: (_, __) => SizedBox(height: 8.h),
                            itemBuilder: (context, index) {
                              final type = controller.affirmationTypes[index];
                              return Obx(() {
                                final isSelected = controller.selectedTypes.contains(type.sId);
                                return _buildAreaItem(type.name ?? '', isSelected, () {
                                  controller.toggleSelection(type.sId!);
                                });
                              });
                            },
                          ),
                        ),

                        // Fixed padding before button
                        SizedBox(height: 20.h),
                      ],
                    );

                  }),
                ),

                // Next Button
                Padding(
                  padding: EdgeInsets.only(bottom: 5.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveSelections,
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
        ),
      ),
    );
  }

  Widget _buildAreaItem(String area, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: double.infinity,
        height: 50.h,
        child: Padding(
          padding: EdgeInsets.only(bottom: 8.h),
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
