import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  Future<void> signUp() async {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String password = passwordController.text.trim();
    String confirmPassword = confirmPasswordController.text.trim();

    if (name.isEmpty || email.isEmpty || password.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar("Error", "All fields are required");
      return;
    }
    if (password != confirmPassword) {
      Get.snackbar("Error", "Passwords do not match");
      return;
    }

    // bool success = await AuthService.signUp(name, email, password);
    bool success = true  ;

    if (success) {
      Get.dialog(
        CustomPopupDialog(
          title: 'Mail Sent',
          description: 'A link has been sent to your registered email to reset your password.',
          primaryButtonText: 'Okay',
          singleButtonMode: true,
          descriptionWidth: 300.w,
          onPrimaryPressed: () {
            Get.back();
            Get.offAllNamed(Routes.LOGIN);
          },
        ),
      );// Redirect to home after successful signup
    } else {
      Get.snackbar("Error", "Signup failed");
    }
  }

  void loginWithGoogle() {
    // Implement Google Login
  }

  void loginWithFacebook() {
    // Implement Facebook Login
  }

  void loginWithApple() {
    // Implement Apple Login (only for iOS)
  }
}
