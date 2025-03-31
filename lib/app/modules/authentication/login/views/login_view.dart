import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
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
            padding: const EdgeInsets.only(left: 20.0 , right: 20 , top: 30),
            child: Column(
              mainAxisSize: MainAxisSize.min, // Takes only required space
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  "Login",
                  style: GoogleFonts.inter(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black
                  ),
                ),

                const SizedBox(height: 40),

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

                SizedBox(height: 12,),

                // Email Input
                TextFormField(
                  controller: controller.emailController,
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "example@gmail.com",
                    hintStyle: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w400, color: Colors.grey),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                  ),
                ),

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

                SizedBox(height: 12,),

                // Password Input
                Obx(() => TextFormField(
                  controller: controller.passwordController,
                  obscureText: controller.isPasswordHidden.value,
                  style: GoogleFonts.inter(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black),
                  decoration: InputDecoration(
                    hintText: "●●●●●●●",
                    hintStyle: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w400, color: Color(0xffD9D9D9)),
                    contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                      borderSide: BorderSide(color: Colors.black26),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    suffixIcon: IconButton(
                      icon: Image.asset(
                          height: 24,
                          width: 24,
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

                const SizedBox(height: 16),

                // Forgot Password?
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () => Get.toNamed('/forgot-password'),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                        fontFamily: "Helvetica Neue",
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 35,),

                // Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.login,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                GestureDetector(
                  onTap: () => Get.toNamed('/guest'),
                  child: Center(
                    child: Text(
                      "Continue as Guest",
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                        decoration: TextDecoration.underline,
                        decorationColor: Colors.black,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 48,),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: Row(
                    children: [
                      Expanded(child: Divider(color: Colors.grey)),
                      SizedBox(width: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10.0),
                        child: Text('or', style: TextStyle(color: Colors.grey, fontSize: 20)),
                      ),
                      SizedBox(width: 10),
                      Expanded(child: Divider(color: Colors.grey)),
                    ],
                  ),
                ),

                SizedBox(height: 20,),

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

                const SizedBox(height: 48),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    Text(
                        "Don't have an account? ",
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
                      onTap: () => Get.toNamed('/signup'),
                      child: Text(
                        "Sign Up",
                        style: TextStyle(
                            fontFamily: "Helvetica Neue",
                            fontSize: 14,
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
    );
  }
}
