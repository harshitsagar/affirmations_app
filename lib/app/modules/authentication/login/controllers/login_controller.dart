import 'package:affirmations_app/app/data/api_service/models/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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

    bool success = await AuthService().login(email, password);
    if (success) {
      Get.offAllNamed('/home');
    } else {
      Get.snackbar("Error", "Invalid credentials or unverified email");
    }
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
