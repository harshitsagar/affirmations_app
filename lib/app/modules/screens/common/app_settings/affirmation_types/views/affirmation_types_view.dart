import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_colors.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/modules/screens/common/app_settings/affirmation_types/controllers/affirmation_types_controller.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class AffirmationTypesView extends GetView<AffirmationTypesController> {
  const AffirmationTypesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AffirmationTypesController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(bgImage2),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                CustomAppBar(
                  title: 'Affirmations Types',
                  onBackPressed: () => Get.back(),
                ),
                SizedBox(height: 20.h),

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
                            separatorBuilder: (_, __) => SizedBox(height: 12.h),
                            itemBuilder: (context, index) {
                              final type = controller.affirmationTypes[index];
                              return Obx(() {
                                final isSelected = controller.selectedTypes.contains(type.sId);
                                return _buildTypeItem(type.name ?? '', isSelected, () {
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

                SizedBox(
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
                      'Save',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
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

  Widget _buildTypeItem(String title, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SvgPicture.asset(
              isSelected ? checkedIcon : uncheckedIcon,
              width: 16.w,
              height: 16.h,
            ),
          ],
        ),
      ),
    );
  }
}
