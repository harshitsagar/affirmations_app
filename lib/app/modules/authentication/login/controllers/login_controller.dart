import 'package:affirmations_app/app/data/api_service/models/auth_service.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void login() async {

    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      Get.snackbar("Error", "Please fill all fields");
      return;
    }

    // bool success = await AuthService().login(email, password);
    bool success = true;  // for just checking the flow ....

    if (success) {

      bool isFirstLogin = await checkIfFirstLogin();

      if (isFirstLogin) {
        Get.offAllNamed(Routes.HOME); // Redirect to Setup Profile screen
      } else {
        Get.offAllNamed(Routes.PROFILE_SCREEN); // Redirect to Home screen
      }
    } else {
      Get.snackbar("Error", "Invalid credentials or unverified email");
    }

  }

  // if the user is new .....
  Future<bool> checkIfFirstLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isProfileSetup") ?? false; // Default is false (means first login)
  }

  // This function should be called when the user completes their profile setup  ....
  void setProfileCompleted() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isProfileSetup", true); // Save that profile setup is done
  }

  void loginWithGoogle() {
    // Handle Google login
  }

  void loginWithFacebook() {
    // Handle Facebook login
  }

  void loginWithApple() {
    // Handle Apple login (iOS only)
  }

  void continueAsGuest() {
    Get.offAllNamed('/home');
  }
}
