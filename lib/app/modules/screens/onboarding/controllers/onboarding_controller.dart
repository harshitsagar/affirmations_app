import 'package:affirmations_app/app/modules/screens/tracking_permission.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OnboardingController extends GetxController {

  final PageController pageController = PageController();
  final currentPage = 0.obs;
  final pageCount = 3;

  void nextPage() {
    if (currentPage.value < pageCount - 1) {
      currentPage.value++;
      pageController.animateToPage(
        currentPage.value,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      Get.dialog(
        const TrackingPermissionDialog(),
        barrierDismissible: false,
      );
    }
  }

}
