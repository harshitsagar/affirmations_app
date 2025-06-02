import 'dart:io';

import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../helpers/services/social_auth.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage(bgImage2),
              fit: BoxFit.cover,
            ),
          ),
          child: SafeArea(
            child: NotificationListener<OverscrollIndicatorNotification>(
              onNotification: (overscroll) {
                overscroll.disallowIndicator();
                return false;
              },
              child: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Custom App Bar .....
                    CustomAppBar(title: "Sign Up"),

                    SizedBox(height: 30.h),

                    Form(
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          // Name Field
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Name*",
                              style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          TextFormField(
                            controller: controller.nameController,
                            keyboardType: TextInputType.name,
                            textCapitalization: TextCapitalization.words, // Automatically capitalize the first letter of each word

                            onChanged: (value) {
                              if (value.isNotEmpty) {
                                controller.formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Name is required';
                              }
                              return null;
                            },
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              hintText: "Johnny",
                              hintStyle: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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

                          // Email Field
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

                          TextFormField(
                            controller: controller.emailController,
                            keyboardType: TextInputType.emailAddress,
                            onChanged: (value) {
                              if (value.isNotEmpty || EmailValidator.validate(value)) {
                                controller.formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Email is required';
                              } else if (!EmailValidator.validate(value)) {
                                return 'Please enter a valid email';
                              }
                              return null;
                            },
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              hintText: "example@gmail.com",
                              hintStyle: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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

                          // Password Field
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

                          Obx(() =>
                              TextFormField(
                                controller: controller.passwordController,
                                obscureText: controller.isPasswordHidden.value,
                                maxLength: 20, // Set maximum limit to 20 characters
                                buildCounter: (_, {required currentLength, required isFocused, maxLength}) => null, // Hides counter

                                onChanged: (value) {
                                  if (value.isNotEmpty && value.length >= 6) {
                                    controller.formKey.currentState!.validate();
                                  }
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } else if (value.length < 6) {
                                    return 'Password must be at least 6 characters';
                                  } else if (value.length > 20) {
                                    return 'Password cannot exceed 20 characters';
                                  }
                                  return null;
                                },
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                                decoration: InputDecoration(
                                  hintText: "●●●●●●●",
                                  hintStyle: GoogleFonts.inter(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: Color(0xffD9D9D9),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                      controller.isPasswordHidden.value ? visible : invisible,
                                    ),
                                    onPressed: controller.togglePasswordVisibility,
                                  ),
                                ),
                              ),),

                          SizedBox(height: 24.h),

                          // Confirm Password Field
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Confirm Password*",
                              style: GoogleFonts.inter(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black
                              ),
                            ),
                          ),

                          SizedBox(height: 12.h),

                          Obx(() => TextFormField(
                            controller: controller.confirmPasswordController,
                            obscureText: controller.isConfirmPasswordHidden.value,
                            onChanged: (value) {
                              if (value.isNotEmpty && value.length >= 6) {
                                controller.formKey.currentState!.validate();
                              }
                            },
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please confirm your password';
                              } else if (value != controller.passwordController.text) {
                                return 'Passwords do not match';
                              }
                              return null;
                            },
                            style: GoogleFonts.inter(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                                color: Colors.black
                            ),
                            decoration: InputDecoration(
                              hintText: "●●●●●●●",
                              hintStyle: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xffD9D9D9)
                              ),
                              contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
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
                                    controller.isConfirmPasswordHidden.value
                                        ? visible
                                        : invisible
                                ),
                                onPressed: controller.toggleConfirmPasswordVisibility,
                              ),
                            ),
                          )),

                        ],
                      ),
                    ),

                    SizedBox(height: 24.h),

                    // Terms and Conditions
                    Text.rich(
                      TextSpan(
                        style: GoogleFonts.inter(
                            fontSize: 14.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.w500
                        ),
                        children: [
                          const TextSpan(text: "You agree to our "),
                          TextSpan(
                            text: "Terms & Conditions",
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                AppConstants.hideKeyboard();
                                Get.to(() =>
                                    Obx(() => InfoPage(
                                        title: "Terms & Conditions",
                                        content: controller.appDetails.termsAndConditions,
                                        loadingStatus: controller.loadingStatus.value
                                    )));
                              },
                          ),
                          const TextSpan(text: " and acknowledge our "),
                          TextSpan(
                            text: "Privacy Policy.",
                            style: const TextStyle(
                              decoration: TextDecoration.underline,
                              fontWeight: FontWeight.bold,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() =>
                                    Obx(() => InfoPage(
                                        title: "Privacy Policy",
                                        content: controller.appDetails.privacyPolicy,
                                        loadingStatus: controller.loadingStatus.value
                                    )));
                              },
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: 40.h),

                    // Sign Up Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (controller.formKey.currentState!.validate()) {
                            AppConstants.showLoader(context: context);
                            controller.signUp(
                              name: controller.nameController.text.trim(),
                              email: controller.emailController.text.trim(),
                              password: controller.passwordController.text.trim(),
                              context: context,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 10.h),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(24.r),
                          ),
                        ),
                        child: Text(
                          "Sign Up",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    // Rest of your existing UI...
                    SizedBox(height: 30.h),
                    _buildDivider(),
                    SizedBox(height: 10.h),
                    _buildSocialLoginButtons(context),
                    SizedBox(height: 25.h),
                    _buildLoginRedirect(),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Helper methods for the remaining UI components
  Widget _buildDivider() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      child: Row(
        children: [
          Expanded(child: Divider(color: Colors.grey)),
          SizedBox(width: 5.w),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.h),
            child: Text(
              'or',
              style: GoogleFonts.inter(
                  color: Colors.grey,
                  fontSize: 16.sp
              ),
            ),
          ),
          SizedBox(width: 5.w),
          Expanded(child: Divider(color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _buildSocialLoginButtons(BuildContext context) {
    return
      Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        if (!Platform.isAndroid) // Show Apple login button only for non-Android users
          IconButton(
            onPressed: controller.loginWithApple,
            icon: Image.asset(apple, height: 48.h, width: 48.w),
          ),
        IconButton(
          onPressed: () => SignInSocialAuth.signInWithGoogle(
            context: context,
          ),
          icon: Image.asset(google, height: 48.h, width: 48.w),
        ),
        IconButton(
          onPressed: controller.loginWithFacebook,
          icon: Image.asset(facebook, height: 48.h, width: 48.w),
        ),
      ],
    );
  }

  Widget _buildLoginRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
            "Already have an account? ",
            style: TextStyle(
              fontFamily: "Helvetica Neue",
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
              color: Color(0xff757575),
            )
        ),
        GestureDetector(
          onTap: () => Get.toNamed('/login'),
          child: Text(
            "Login",
            style: TextStyle(
                fontFamily: "Helvetica Neue",
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black,
                decoration: TextDecoration.underline,
                decorationColor: Colors.black
            ),
          ),
        ),
      ],
    );
  }
}