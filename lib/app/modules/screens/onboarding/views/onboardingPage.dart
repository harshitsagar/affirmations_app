import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 63.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ensuring Image Scales Properly
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.35.h, // Keeps a uniform image height
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // Ensures full image is visible without distortion
            ),
          ),

          SizedBox(height: 52.h),

          SizedBox(
            width: 300.w,
            height: 52.h,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                height: 1.2.h,
                color: Color(0xff12121D),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          SizedBox(
            width: 330.w,
            height: 60.h,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.black,
                height: 1.2.h,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

