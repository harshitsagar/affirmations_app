import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:get/get.dart';

class SubscriptionScreenController extends GetxController {

  // Handle cancel button press
  void onCancelPressed() {
    Get.offAllNamed(Routes.HOME); // Redirect to Home screen
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