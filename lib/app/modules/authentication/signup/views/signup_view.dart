import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: ListView(
              // mainAxisAlignment: MainAxisAlignment.center,
              // crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                // Custom App Bar .....
                CustomAppBar(title: "Sign Up"),

                const SizedBox(height: 30),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Name*",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Name Input
                _buildTextField(controller.nameController, "Name"),

                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email*",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Email Input
                _buildTextField(controller.emailController, "Email"),

                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Password*",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Password Input
                Obx(() => _buildPasswordField(controller.passwordController, "●●●●●●●",
                    controller.isPasswordHidden, controller.togglePasswordVisibility)),

                const SizedBox(height: 24),

                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Confirm Password*",
                    style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // Confirm Password Input
                Obx(() => _buildPasswordField(controller.confirmPasswordController, "●●●●●●●",
                    controller.isConfirmPasswordHidden, controller.toggleConfirmPasswordVisibility)),

                const SizedBox(height: 24),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text.rich(
                    TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.black,
                        fontWeight: FontWeight.w500
                      ), // Default text style
                      children: [

                        TextSpan(text: "You agree to our "), // Normal text

                        TextSpan(
                          text: "Terms & Conditions",
                          style: const TextStyle(
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
                          style: const TextStyle(
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
                ),

                SizedBox(height: 40),

                // SignUp Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.signUp,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        "Sign Up",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // Divider
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text(
                            'or',
                            style: GoogleFonts.inter(
                                color: Colors.grey,
                                fontSize: 16)
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

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
                      icon: Image.asset(google, height: 48, width: 48),
                    ),

                    IconButton(
                      onPressed: controller.loginWithFacebook,
                      icon: Image.asset(facebook, height: 48, width: 48),
                    ),

                  ],
                ),

                const SizedBox(height: 25),

                // Already have an account? Login
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                        "Already have an account? ",
                        style: TextStyle(
                          fontFamily: "Helvetica Neue",
                          fontSize: 14,
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
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
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
    );
  }

  // Helper function for text fields
  Widget _buildTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black26),
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
      height: 40,
      child: TextFormField(
        controller: controller,
        obscureText: isHidden.value,
        style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w400, color: const Color(0xffD9D9D9)),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: const BorderSide(color: Colors.black26),
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
          suffixIcon: IconButton(
            icon: Image.asset(
              height: 24,
              width: 24,
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
