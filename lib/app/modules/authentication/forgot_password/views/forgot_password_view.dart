import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/utils/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/forgot_password_controller.dart';

class ForgotPasswordView extends GetView<ForgotPasswordController> {
  const ForgotPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage), // Add correct path
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                CustomAppBar(title: "Forgot Password"),

                const SizedBox(height: 40),

                // Subtitle
                Text(
                  "Please enter your registered email to reset your password.",
                  // textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 24),

                // Email Input Field
                TextFormField(
                  controller: controller.emailController,
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500),
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    hintStyle: GoogleFonts.inter(fontSize: 14, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                  ),
                ),

                const SizedBox(height: 42),

                // Request Reset Link Button
                ElevatedButton(
                  onPressed: controller.sendResetLink,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Request Reset Link",
                    style: GoogleFonts.inter(
                      fontSize: 16,
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
    );
  }
}
