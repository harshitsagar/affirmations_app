import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
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
      CustomPopupDialog(
        title: 'Mail Sent',
        description: 'A link has been sent to your registered email to reset your password.',
        primaryButtonText: 'Okay',
        singleButtonMode: true,
        descriptionWidth: 300,
        onPrimaryPressed: () {
          Get.back();
          Get.offAllNamed(Routes.LOGIN);
        },
      ),
    );

  }
}
