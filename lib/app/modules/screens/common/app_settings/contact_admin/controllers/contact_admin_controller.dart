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


  @override
  void onClose() {
    messageController.dispose();
    super.onClose();
  }
}
