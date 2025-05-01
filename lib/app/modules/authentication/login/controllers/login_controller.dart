import 'dart:io';

import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/user_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {

  final formKey = GlobalKey<FormState>();

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var isPasswordHidden = true.obs;

  var loadingStatus = LoadingStatus.loading.obs;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void signIn({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    // String? fcmToken = LocalStorage.getFCMToken();
    try {
      loadingStatus(LoadingStatus.loading);
      final response = await APIProvider().postAPICall(
        ApiConstants.signIn,
        {
          "email": email.toString(),
          "password": password.toString(),
          "device": Platform.isAndroid ? "android" : "ios",
          // "fcmToken": fcmToken.toString(),
          "timeZone": timeZone,
        },
        {
          'Content-Type': 'application/json',
        },
      );
      if (response.data["code"] == 100) {
        UserModel userModel = UserModel.fromJson(response.data);
        var data = userModel.data;

        LocalStorage.setUserAccessToken(
          userAccessToken: data.accessToken,
        );
        LocalStorage.setUserDetailsData(
          userDetailsData: data.user,
        );

        Future.delayed(
          const Duration(seconds: 1),
              () {
            AppConstants.showSnackbar(
              headText: "Successful",
              content: "Signing in...",
            );
            Get.offAllNamed(Routes.PROFILE_SCREEN);
          },
        );
      } else if (response.data["code"] == 103) {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: "Requested user not found.",
        );
      } else if (response.data["code"] == 500) {
        Get.back();
        if (response.data["message"] == "Your account has been deleted.") {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Your account has been deleted.",
          );
        } else if (response.data["message"] ==
            "Your account has been blocked.") {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Your account has been blocked.",
          );
        } else if (response.data["message"] ==
            "Kindly set the password for the email.") {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Kindly set the password for the email.",
          );
        } else if (response.data["message"] ==
            "Your account has not been verified. Kindly verify the email.") {
          AppConstants.showSnackbar(
            headText: "Failed",
            content:
            "Your account has not been verified. Kindly verify the email.",
          );
        } else {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: response.data["message"],
          );
        }
      } else {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
        );
      }
    } catch (e) {
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
      );
    }
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

  // Handles Google sign-in logic
  Future<void> googleSignIn({
    required String name,
    required String email,
    required int socialIdentifier,
    required String socialId,
    required String socialToken,
    required String? picture,
    required BuildContext context,
  }) async {
    String? fcmToken = LocalStorage.getFCMToken();
    try {
      AppConstants.showLoader(context: context);

      final response = await APIProvider().postAPICall(
        ApiConstants.socialLogin,
        {
          "name": name,
          "email": email,
          "socialIdentifier": socialIdentifier,
          "socialId": socialId,
          "socialToken": socialToken,
          "picture": picture,
          "device": Platform.isAndroid ? "android" : "ios",
          "fcmToken": fcmToken.toString(),
          "timeZone": timeZone,
        },
        {
          'Content-Type': 'application/json',
        },
      );
      if (response.data['code'] == 100) {
        // Process successful login and save user data
        final UserModel userModel = UserModel.fromJson(response.data);
        var data = UserData.fromJson(response.data["data"]);

        LocalStorage.setUserAccessToken(userAccessToken: data.accessToken);
        LocalStorage.setUserDetailsData(
          userDetailsData: data.user,
        );

        AppConstants.showSnackbar(
          headText: "Successful",
          content: "Signing in...",
        );
        // Get.offNamedUntil(
        //   Routes.BOTTOM_NAVIGATION_BAR,
        //       (route) => false,
        // );
      } else {
        // Handle specific error scenarios
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data['message'],
        );
      }
    } catch (e) {
      // Handle general errors during Google sign-in
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
      );
    }
  }

  // Handles Facebook sign-in logic (similar to Google and Apple sign-ins)
  Future<void> facebookSignIn({
    required String name,
    required String email,
    required String socialId,
    required String socialToken,
    required int socialIdentifier,
    required BuildContext context,
  }) async {
    // Implementation is similar to googleSignIn
    String? fcmToken = LocalStorage.getFCMToken();
    try {
      AppConstants.showLoader(context: context);

      final response = await APIProvider().postAPICall(
        ApiConstants.socialLogin,
        {
          'name': name,
          "email": email,
          "socialId": socialId,
          "socialToken": socialToken,
          "socialIdentifier": socialIdentifier,
          "device": Platform.isAndroid ? "android" : "ios",
          "fcmToken": fcmToken.toString(),
          "timeZone": timeZone,
        },
        {
          'Content-Type': 'application/json',
        },
      );
      if (response.data['code'] == 100) {
        final UserModel userModel = UserModel.fromJson(response.data);
        var data = UserData.fromJson(response.data["data"]);

        LocalStorage.setUserAccessToken(userAccessToken: data.accessToken);
        LocalStorage.setUserDetailsData(
          userDetailsData: data.user,
        );

        AppConstants.showSnackbar(
          headText: "Successful",
          content: "Signing in...",
        );
        // Get.offNamedUntil(
        //   Routes.BOTTOM_NAVIGATION_BAR,
        //       (route) => false,
        // );
      } else {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data['message'],
        );
      }
    } catch (e) {
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
      );
    }
  }

  // Handles Apple sign-in logic (similar to Google sign-in)
  Future<void> appleSignIn({
    required String name,
    required String email,
    required int socialIdentifier,
    required String socialId,
    required String socialToken,
    String? picture,
    required BuildContext context,
  }) async {
    // Implementation is similar to googleSignIn
    String? fcmToken = LocalStorage.getFCMToken();
    try {
      final response = await APIProvider().postAPICall(
        ApiConstants.socialLogin,
        {
          "name": name,
          "email": email,
          "socialIdentifier": socialIdentifier,
          "socialId": socialId,
          "socialToken": socialToken,
          "picture": picture,
          "device": Platform.isAndroid ? "android" : "ios",
          "fcmToken": fcmToken,
          "timeZone": timeZone,
        },
        {
          'Content-Type': 'application/json',
        },
      );

      if (response.data['code'] == 100) {
        final UserModel userModel = UserModel.fromJson(response.data);
        var data = UserData.fromJson(response.data["data"]);

        LocalStorage.setUserAccessToken(userAccessToken: data.accessToken);
        LocalStorage.setUserDetailsData(
          userDetailsData: data.user,
        );

        AppConstants.showSnackbar(
          headText: "Successful",
          content: "Signing in...",
        );
        // Get.offNamedUntil(
        //   Routes.BOTTOM_NAVIGATION_BAR,
        //       (route) => false,
        // );
      } else {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data['message'],
        );
      }
    } catch (e) {
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void continueAsGuest() {
    Get.offAllNamed('/home');
  }

  void loginWithApple() {
  }

  void loginWithGoogle() {
  }

  void loginWithFacebook() {
  }
}
