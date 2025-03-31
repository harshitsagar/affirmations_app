import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {
  final TextEditingController emailController = TextEditingController();

  // Function to handle reset password API call
  void sendResetLink() async {
    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar("Error", "Please enter your email", backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }

    try {
      // Simulating API Call (Replace with real API)
      await Future.delayed(Duration(seconds: 2));

      // Show success message
      Get.snackbar("Success", "A reset link has been sent to your email",
          backgroundColor: Colors.green, colorText: Colors.white);

    } catch (error) {
      Get.snackbar("Error", "Something went wrong. Try again.", backgroundColor: Colors.red, colorText: Colors.white);
    }
  }
}
