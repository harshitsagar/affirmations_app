import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HearAboutController extends GetxController {

  // Static list .....
  final options = <String>[
    'App Store',
    'Google Play',
    'Tiktok',
    'Instagram',
    'Friend/ Family',
    'Web Search',
    'Email',
    'Others'
  ].obs;

  final selectedOptions = <String>[].obs;

  void toggleOptionSelection(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }

  void navigateToSubscriptionScreen() {
    Get.toNamed(Routes.SUBSCRIPTION_SCREEN);
  }

}