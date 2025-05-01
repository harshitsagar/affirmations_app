import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgotPasswordController extends GetxController {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  void resetPassword({
    required String email,
    required BuildContext context,
  }) async {
    try {
      final response = await APIProvider().postAPICall(
        ApiConstants.forgotPassword,
        {
          "requestType": 1,
          "email": email,
        },
        {},
      );
      if (response.data["code"] == 100) {
        Future.delayed(
          const Duration(seconds: 1),
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
            );
          },
        );
      } else if (response.data["code"] == 101) {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: "Missing email required property.",
        );
      } else if (response.data["code"] == 500) {
        Get.back();
        if (response.data["message"] ==
            'No account registered with this email address.') {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "No account registered with this email address.",
          );
        } else {
          AppConstants.showSnackbar(
            headText: "Failed",
            content: "Please verify your email id First.",
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

}
