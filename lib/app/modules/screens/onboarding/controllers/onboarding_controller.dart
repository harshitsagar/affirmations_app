import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        CustomPopupDialog(
          title: 'Tracking Permission',
          description: 'Allow "Affirmations" to track your activity across other companies\' apps and websites?',
          // No need to specify button texts as they're now the defaults
          onPrimaryPressed: () async{
            await LocalStorage.setOnboardingCompleted();
            Get.back();
            Get.offAllNamed(Routes.LOGIN);
          },
          onSecondaryPressed: () async {
            await LocalStorage.setOnboardingCompleted();
            Get.back();
            Get.offAllNamed(Routes.LOGIN);
          },
          primaryButtonSize: 14.sp,
          secondaryButtonSize: 14.sp,
          descriptionWidth: 360.w,
        ),
        barrierDismissible: false,
      );

    }
  }

}
