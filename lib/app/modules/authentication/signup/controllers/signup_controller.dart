import 'dart:io';

import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/app_details_model.dart';
import 'package:affirmations_app/app/data/models/sign_up_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignupController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  var loadingStatus = LoadingStatus.loading.obs;

  var isPasswordHidden = true.obs;
  var isConfirmPasswordHidden = true.obs;

  final _appDetails = Rx<AppData>(AppData());

  AppData get appDetails => _appDetails.value;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  @override
  void onInit() {
    fetchAppDatails();
    super.onInit();
  }

  void fetchAppDatails() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final response = await APIProvider().postAPICall(
        ApiConstants.appDetails,
        {},
        {},
      );
      if (response.data["code"] == 100) {
        _appDetails.value = AppData.fromJson(response.data["data"]);
        update();
      } else {
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
      );
    }
    loadingStatus(LoadingStatus.completed);
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // String? fcmToken = LocalStorage.getFCMToken();
    try {
      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.signUp,
        {
          "name": name,
          "email": email,
          "password": password,
          "device": Platform.isAndroid ? "android" : "ios",
          // "fcmToken": fcmToken.toString(),
        },
        {
          'Content-Type': 'application/json',
        },
      );
      var data = SignUpModel.fromJson(response);
      if (data.code == 100) {
        Future.delayed(
          const Duration(milliseconds: 600),
              () {
            Get.back();
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
          },
        );
      } else if (data.code == 500) {
        Get.back();
        if (data.message == "Email $email is already registered.") {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Email $email is already registered.",
          );
        } else if (data.message == "Error sending email.") {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Error sending email.",
          );
        }
      }
    } catch (e) {
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
      );
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
