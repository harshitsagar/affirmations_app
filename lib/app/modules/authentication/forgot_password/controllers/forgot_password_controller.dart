import 'package:affirmations_app/app/widgets/mailSent.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

  final TextEditingController emailController = TextEditingController();

  // Function to handle reset password API call
  void sendResetLink() async {

    String email = emailController.text.trim();

    if (email.isEmpty) {
      Get.snackbar(
          "Please enter your email",
          "Email field cannot be empty",
          backgroundColor: Colors.black,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    Get.dialog(
      MailSent(),
      barrierDismissible: false,
    );

  }
}
