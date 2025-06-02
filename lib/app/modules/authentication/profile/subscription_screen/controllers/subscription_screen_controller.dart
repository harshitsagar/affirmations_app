import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/helpers/services/purchase_service.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:get/get.dart';
import '../../../../../helpers/constants/purchase_constants.dart';

class SubscriptionScreenController extends GetxController {

  final purchaseService = Get.find<PurchaseService>();

  // Handle cancel button press
  void onCancelPressed() {
    final fromProfileSetup = Get.previousRoute == Routes.HEAR_ABOUT;

    if (fromProfileSetup) {
      // If coming from profile setup, mark profile as completed and go to home
      LocalStorage.setProfileCompleted(value: true);
      Get.offAllNamed(Routes.HOME);
    } else {
      // If coming from elsewhere (like theme selection), just go back
      Get.back();
    }
  }

  // Handle go premium button press
  void onGoPremiumPressed() {
    // For lifetime purchase
    purchaseService.purchaseProduct(lifetimePurchaseId).catchError((error) {
      Get.snackbar('Error', 'Purchase failed: $error');
    });
  }

  // Handle terms & conditions press
  void onTermsPressed() {
    Get.to(() => const InfoPage(title: "Terms & Conditions"));
  }
}