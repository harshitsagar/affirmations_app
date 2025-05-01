import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ContactAdminController extends GetxController {
  final messageController = TextEditingController();
  final charCount = 0.obs;
  final isSendEnabled = false.obs;

  @override
  void onInit() {
    super.onInit();
    messageController.addListener(_handleInputChange);
  }

  void _handleInputChange() {
    charCount.value = messageController.text.length;
    isSendEnabled.value = messageController.text.trim().isNotEmpty;
  }

  void contactAdmin(BuildContext context) async {
    try {
      var accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.contactAdmin,
        {
          'message': messageController.text,
        },
        {
          'Authorization': accessToken,
        },
      );
      if (response.data["code"] == 100) {
        Get.back();
        // Success popup
        Get.dialog(
          CustomPopupDialog(
            title: 'Mail Sent',
            description: 'Thank you for contacting us. We will try getting back to you as soon as possible.',
            primaryButtonText: 'Okay',
            singleButtonMode: true,
            descriptionWidth: 300.w,
            onPrimaryPressed: () {
              Get.back(); // close dialog
              Get.back(); // back to last screen
            },
          ),
        );

        // Clear message
        messageController.clear();

      } else {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
          position: SnackPosition.BOTTOM,
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

  /*
  void sendMessage() {
    final message = messageController.text.trim();

    if (message.isEmpty) {
      Get.snackbar(
        "Error",
        "Please enter your message before sending.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        margin: EdgeInsets.all(16),
        duration: Duration(seconds: 2),
      );
      return;
    }

    // Success popup
    Get.dialog(
      CustomPopupDialog(
        title: 'Mail Sent',
        description: 'Thank you for contacting us. We will try getting back to you as soon as possible.',
        primaryButtonText: 'Okay',
        singleButtonMode: true,
        descriptionWidth: 300.w,
        onPrimaryPressed: () {
          Get.back(); // close dialog
          Get.back(); // back to last screen
        },
      ),
    );

    // Clear message
    messageController.clear();
  }
   */


  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
