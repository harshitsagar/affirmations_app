import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/purchase_screen_controller.dart';

class PurchaseScreenView extends GetView<PurchaseScreenController> {
  const PurchaseScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Cancel button row

                GestureDetector(
                  onTap: controller.onCancelPressed,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [

                      Image.asset(crossIcon, height: 24.h, width: 24.w),

                      SizedBox(width: 5.w),

                      Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 30.h),

                // Title
                Center(
                  child: Text(
                    '${controller.type} Streak',
                    style: GoogleFonts.inter(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 20.h),

                // Image
                Center(
                  child: SvgPicture.asset(
                    controller.type == 'Freeze' ? freezeStreakIcon : restoreStreakIcon,
                    height: 91.h,
                    width: 119.w,
                  ),
                ),

                SizedBox(height: 30.h),

                if (controller.type == 'Freeze') ...[
                  _buildFeatureItem('Protect Your Progress'),
                  _buildFeatureItem('Plan Ahead & Stay Flexible'),
                  _buildFeatureItem('Stay Motivated'),
                ] else ...[
                  _buildFeatureItem('Get Back On Track'),
                  _buildFeatureItem('Keep Your Achievements'),
                  _buildFeatureItem('Stay Motivated'),
                ],

                SizedBox(height: 20.h),

                // Packages
                Obx(() => Column(
                  children: [
                    _buildPackageOption(
                      title: 'Single ${controller.type}',
                      description: '1 Streak ${controller.type}',
                      price: '\$1.99',
                      isSelected: controller.selectedPackage.value == 0,
                      onTap: () => controller.selectPackage(0),
                      showBestValue: false, // No badge for single package
                    ),
                    SizedBox(height: 10.h),
                    _buildPackageOption(
                      title: '${controller.type} Bundle',
                      description: '5 Streak ${controller.type}s',
                      price: '\$6.99',
                      isSelected: controller.selectedPackage.value == 1,
                      onTap: () => controller.selectPackage(1),
                      showBestValue: true, // Show badge for bundle
                    ),
                    SizedBox(height: 10.h),
                    _buildPackageOption(
                      title: 'Complete Package',
                      description: '5 Freezes + 5 Restores',
                      price: '\$11.99',
                      isSelected: controller.selectedPackage.value == 2,
                      onTap: () => controller.selectPackage(2),
                      showBestValue: false, // No badge for complete package
                    ),
                  ],
                )),

                SizedBox(height: 20.h),

                // Purchase button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.onPurchasePressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                    ),
                    child: Text(
                      'Purchase Now',
                      style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 10.h),

                // Terms & Conditions
                Center(
                  child: TextButton(
                    onPressed: controller.onTermsPressed,
                    child: Text(
                      'Terms & Conditions',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
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

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 50.w, bottom: 14.h),
      child: Row(
        children: [
          Image.asset(
            blackTickIcon,
            height: 20.h,
            width: 20.w,
          ),
          SizedBox(width: 12.w),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBestValueBadge() {
    return Positioned(
      top: -12.h,
      right: 20.w,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
        decoration: BoxDecoration(
          color: Color(0xFFFF92D2), // Pink color from your design
          borderRadius: BorderRadius.circular(20.r),
        ),
        child: Text(
          'Best Value',
          style: GoogleFonts.inter(
            fontSize: 12.sp,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildPackageOption({
    required String title,
    required String description,
    required String price,
    required bool isSelected,
    required VoidCallback onTap,
    required bool showBestValue, // Add this parameter
  }) {
    return Stack(
      clipBehavior: Clip.none, // Important for the badge positioning
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            margin: EdgeInsets.only(bottom: 16.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.6),
              borderRadius: BorderRadius.circular(22.r),
              border: Border.all(
                color: Colors.white.withOpacity(0.5),
                width: 1.w,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  isSelected ? selectedIcon : unselectedIcon,
                  width: 16.w,
                  height: 16.h,
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFFA9A9A9),
                        ),
                      ),
                      SizedBox(height: 2.h),
                      Text(
                        description,
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Text(
                      price,
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(width: 12.w),
                  ],
                ),
              ],
            ),
          ),
        ),
        // Show the badge only for the bundle package
        if (showBestValue) _buildBestValueBadge(),
      ],
    );
  }
}