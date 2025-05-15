import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:get/get.dart';

class SubscriptionScreenController extends GetxController {

  // Handle cancel button press
  void onCancelPressed() {
    if (LocalStorage.getProfileCompleted()) {
      // If profile is completed, go to home screen
      Get.offAllNamed(Routes.HOME);
      LocalStorage.setProfileCompleted(value: false);
    } else {
      // Otherwise, just go back
      Get.back();
    }
  }

  // Handle go premium button press
  void onGoPremiumPressed() {
    Get.toNamed('/purchase-subscription'); // Redirect to Purchase Subscription screen
  }

  // Handle terms & conditions press
  void onTermsPressed() {
    Get.to(() => const InfoPage(title: "Terms & Conditions"));
  }
}