import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/social_auth.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AppConstants.hideKeyboard();
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          // decoration: BoxDecoration(
          //   image: DecorationImage(
          //     image: AssetImage(bgImage), // Background Image
          //     fit: BoxFit.cover, // Cover the full screen
          //   ),
          // ),
          decoration: ThemeService.getBackgroundDecoration(),
          child: SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (OverscrollIndicatorNotification notification) {
                notification.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20.w , right: 20.w , top: 20.h),
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

                    Form(
                      key: controller.formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min, // Takes only required space
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [

                          // Form Header ......
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
                            onChanged: (value) {
                              if (EmailValidator.validate(value)) {
                                controller.formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Email field can't be empty";
                              } else if (!EmailValidator.validate(value)) {
                                return "Incorrect email address";
                              }
                              return null;
                            },
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
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
                            onChanged: (value) {
                              if (value.isNotEmpty && value.length >= 6) {
                                controller.formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Password field can't be empty";
                              } else if (value.length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
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
                              errorBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.r),
                                borderSide: BorderSide(color: Colors.transparent),
                              ),
                              focusedErrorBorder: OutlineInputBorder(
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
                              onPressed: () {
                                AppConstants.hideKeyboard();
                                Get.toNamed(Routes.FORGOT_PASSWORD);
                              },
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

                        ],
                      ),
                    ),

                    SizedBox(height: 30.h),

                    // Login Button
                    SizedBox(
                      width: 1.sw,
                      child: ElevatedButton(
                        onPressed: () {
                          AppConstants.hideKeyboard();
                          if (controller.formKey.currentState!.validate()) {
                            AppConstants.showLoader(context: context);
                            controller.signIn(
                              context: context,
                              email: controller.emailController.text.trim(),
                              password: controller.passwordController.text.trim(),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                          padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 10.h),
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
                      onTap: () => Get.offAllNamed(Routes.HOME),
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

                    // Social Login Buttons.....
                    Row(
                      mainAxisAlignment: Platform.isAndroid
                          ? MainAxisAlignment.spaceEvenly // Adjust spacing for Android
                          : MainAxisAlignment.spaceEvenly, // Adjust spacing for Apple
                      children: [
                        if (!Platform.isAndroid) // Show Apple login button only for non-Android users
                          IconButton(
                            onPressed: () => SignInSocialAuth.signInWithApple(
                              context: context,
                            ),
                            icon: Image.asset(apple, height: 48, width: 48),
                          ),
                        IconButton(
                          onPressed: () => SignInSocialAuth.signInWithGoogle(
                            context: context,
                          ),
                          icon: Image.asset(google, height: 48.h, width: 48.w),
                        ),
                        // IconButton(
                        //   onPressed: () => SignInSocialAuth.signInWithFacebook(
                        //     context: context,
                        //   ),
                        //   icon: Image.asset(facebook, height: 48.h, width: 48.w),
                        // ),
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
                          onTap: () {
                            AppConstants.hideKeyboard();
                            Get.toNamed(Routes.SIGNUP);
                          },
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
      ),
    );
  }
}
