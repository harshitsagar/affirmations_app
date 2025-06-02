import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

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
          //     image: AssetImage(bgImage),
          //     fit: BoxFit.cover,
          //   ),
          // ),
          decoration: ThemeService.getBackgroundDecoration(),
          child: NotificationListener<OverscrollIndicatorNotification>(
            onNotification: (notification) {
              notification.disallowIndicator();
              return false;
            },
            child: SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: Form(
                  key: controller.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      CustomAppBar(title: "Forgot Password"),

                      SizedBox(height: 30.h),

                      // Subtitle
                      Text(
                        "Please enter your registered email to reset your password.",
                        // textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // Email Input Field
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
                        style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          hintText: "example@gmail.com",
                          hintStyle: GoogleFonts.inter(fontSize: 14.sp, color: Colors.grey),
                          contentPadding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 12.h),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.r),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                        ),
                      ),

                      SizedBox(height: 42.h),

                      // Request Reset Link Button
                      ElevatedButton(
                        onPressed: () {
                          AppConstants.hideKeyboard();
                          if (controller.formKey.currentState!.validate()) {
                            AppConstants.showLoader(context: context);
                            controller.resetPassword(
                              email: controller.emailController.text.trim(),
                              context: context,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.r),
                          ),
                          minimumSize: Size(1.sw, 45.h),
                        ),
                        child: Text(
                          "Request Reset Link",
                          style: GoogleFonts.inter(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
