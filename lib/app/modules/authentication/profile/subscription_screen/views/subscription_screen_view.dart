import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/subscription_screen_controller.dart';

class SubscriptionScreenView extends GetView<SubscriptionScreenController> {
  const SubscriptionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(bgImage2),
        //     fit: BoxFit.contain,
        //   ),
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 20.h),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      IconButton(
                        icon: Image.asset(crossIcon, height: 20.h),
                        onPressed: controller.onCancelPressed,
                      ),
              
                      Text(
                        'Cancel',
                        style: GoogleFonts.inter(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
              
                  SizedBox(height: 50.h),
              
                  // Title
                  Text(
                    'Unlock Premium Access',
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.black,
                    ),
                  ),
              
                  SizedBox(height: 20.h),
              
                  SizedBox(
                    height: 172.h,
                    width: 224.w,
                    child: Image.asset(
                      crownIcon,
                    ),
                  ),
              
                  SizedBox(height: 20.h),
              
                  // Features List
                  _buildFeatureItem('Removes All Ads'),
                  _buildFeatureItem('Unlock All Themes'),
                  _buildFeatureItem('3 Free Streak Freezes'),
                  _buildFeatureItem('Lifetime Access'),

                  SizedBox(height: 40.h,),
              
                  // Go Premium Button (matching your sample style)
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.onGoPremiumPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        '\$19.99 Go Premium',
                        style: GoogleFonts.inter(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 10.h),
              
                  // Terms & Conditions (matching your text button style)
                  TextButton(
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
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: EdgeInsets.only(left: 65.w, bottom: 18.h),
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
}