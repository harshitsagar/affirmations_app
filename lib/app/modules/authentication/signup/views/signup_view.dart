import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/signup_controller.dart';

class SignupView extends GetView<SignupController> {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2), // Background Image
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Custom App Bar .....
                CustomAppBar(title: "Sign Up"),

                SizedBox(height: 30.h),

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

                // Name Input
                _buildTextField(controller.nameController, "Name"),

                SizedBox(height: 24.h),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email*",
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Email Input
                _buildTextField(controller.emailController, "Email"),

                SizedBox(height: 24.h),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password*",
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Password Input
                Obx(() => _buildPasswordField(controller.passwordController, "●●●●●●●",
                    controller.isPasswordHidden, controller.togglePasswordVisibility)),

                SizedBox(height: 24.h),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Confirm Password*",
                    style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                SizedBox(height: 12.h),

                // Confirm Password Input
                Obx(() => _buildPasswordField(controller.confirmPasswordController, "●●●●●●●",
                    controller.isConfirmPasswordHidden, controller.toggleConfirmPasswordVisibility)),

                SizedBox(height: 24.h),

                Text.rich(
                  TextSpan(
                    style: GoogleFonts.inter(
                      fontSize: 14.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.w500
                    ), // Default text style
                    children: [

                      TextSpan(text: "You agree to our "), // Normal text

                      TextSpan(
                        text: "Terms & Conditions",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold, // Optional bold effect
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => const InfoPage(title: "Terms & Conditions"));
                          },
                      ),

                      const TextSpan(text: " and acknowledge our "), // Normal text

                      TextSpan(
                        text: "Privacy Policy.",
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.bold, // Optional bold effect
                        ),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Get.to(() => InfoPage(title: "Privacy Policy"));
                          },
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center, // Ensures it stays centered
                ),

                SizedBox(height: 40.h),

                // SignUp Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.r),
                      ),
                    ),
                    child: Center(
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
                ),

                SizedBox(height: 30.h),

                // Divider
                Padding(
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
                ),

                SizedBox(height: 10.h),

                // Social Login Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    IconButton(
                      onPressed: controller.loginWithApple,
                      icon: Image.asset(apple, height: 48.h, width: 48.w),
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

                SizedBox(height: 25.h),

                // Already have an account? Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Already have an account? ",
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
                ),

                SizedBox(height: 20.h),

              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper function for text fields
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      height: 40.h,
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(fontSize: 16.sp, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w400, color: Colors.grey),
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
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  // Helper function for password fields
  Widget _buildPasswordField(
      TextEditingController controller, String hintText, RxBool isHidden, VoidCallback toggleVisibility) {
    return SizedBox(
      height: 40.h,
      child: TextFormField(
        controller: controller,
        obscureText: isHidden.value,
        style: GoogleFonts.inter(fontSize: 14.sp, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(fontSize: 10.sp, fontWeight: FontWeight.w400, color: const Color(0xffD9D9D9)),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.h),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          suffixIcon: IconButton(
            icon: Image.asset(
              height: 24.h,
              width: 24.w,
              isHidden.value ? visible : invisible,
            ),
            color: Colors.black54,
            onPressed: toggleVisibility,
          ),
        ),
      ),
    );
  }

}
