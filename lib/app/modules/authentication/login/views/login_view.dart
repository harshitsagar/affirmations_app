import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage), // Background Image
            fit: BoxFit.cover, // Cover the full screen
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w , right: 20.w , top: 20.h),
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min, // Takes only required space
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
              
                  Text(
                    "Login",
                    style: GoogleFonts.inter(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black
                    ),
                  ),
              
                  SizedBox(height: 40.h),
              
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Email*",
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                    ),
                  ),
              
                  SizedBox(height: 12.h),
              
                  // Email Input
                  TextFormField(
                    controller: controller.emailController,
                    style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "example@gmail.com",
                      hintStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                    ),
                  ),
              
                  SizedBox(height: 24.h),
              
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Password*",
                      style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black
                      ),
                    ),
                  ),
              
                  SizedBox(height: 12.h),
              
                  // Password Input
                  Obx(() => TextFormField(
                    controller: controller.passwordController,
                    obscureText: controller.isPasswordHidden.value,
                    style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
                    decoration: InputDecoration(
                      hintText: "●●●●●●●",
                      hintStyle: GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Color(0xffD9D9D9)),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.transparent),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.r),
                        borderSide: BorderSide(color: Colors.black26),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      suffixIcon: IconButton(
                        icon: Image.asset(
                            height: 24.h,
                            width: 24.w,
                            controller.isPasswordHidden.value
                                ? visible
                                : invisible
                        ),
                        color: Colors.black54,
                        onPressed: controller.togglePasswordVisibility,
                      ),
                    ),
                  ),
                  ),
              
                  SizedBox(height: 8.h),
              
                  // Forgot Password?
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Get.toNamed('/forgot-password'),
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(
                          fontFamily: "Helvetica Neue",
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 30.h),
              
                  // Login Button
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.login,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24.r),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 14.h),
                      ),
                      child: Text(
                        "Login",
                        style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 24.h),
              
                  GestureDetector(
                    onTap: () => Get.toNamed('/guest'),
                    child: Center(
                      child: Text(
                        "Continue as Guest",
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.black,
                        ),
                      ),
                    ),
                  ),
              
                  SizedBox(height: 40.h),
              
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10.w),
                    child: Row(
                      children: [
                        Expanded(child: Divider(color: Colors.grey)),
                        SizedBox(width: 10.w),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text('or', style: TextStyle(color: Colors.grey, fontSize: 20.sp)),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(child: Divider(color: Colors.grey)),
                      ],
                    ),
                  ),
              
                  SizedBox(height: 20.h),
              
                  // Social Login Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
              
                      IconButton(
                        onPressed: controller.loginWithApple,
                        icon: Image.asset(apple, height: 48, width: 48),
                      ),
              
                      IconButton(
                        onPressed: controller.loginWithGoogle,
                        icon: Image.asset(google, height: 48.h, width: 48.w),
                      ),
              
                      IconButton(
                        onPressed: controller.loginWithFacebook,
                        icon: Image.asset(facebook, height: 48.h, width: 48.w),
                      ),
              
                    ],
                  ),
              
                  SizedBox(height: 30.h),
              
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
              
                      Text(
                          "Don't have an account? ",
                          style: TextStyle(
                              fontFamily: "Helvetica Neue",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Color(0xff757575),
                              // decoration: TextDecoration.underline,
                              // decorationColor: Colors.black
                          )
                      ),
              
                      GestureDetector(
                        onTap: () => Get.toNamed('/signup'),
                        child: Text(
                          "Sign Up",
                          style: TextStyle(
                              fontFamily: "Helvetica Neue",
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                              decorationColor: Colors.black
                          ),
                        ),
                      ),
              
                    ],
                  ),
              
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
