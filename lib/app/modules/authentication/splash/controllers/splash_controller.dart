import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    navigateTo();
    super.onInit();
  }

  Future<void> navigateTo() async {
    await Future.delayed(const Duration(seconds: 2));

    final hasCompletedOnboarding = LocalStorage.getOnboardingCompleted();
    final isLoggedIn = LocalStorage.getUserAccessToken()?.isNotEmpty ?? false;
    final profileCompleted = LocalStorage.getProfileCompleted();

    if (!hasCompletedOnboarding) {
      // First time user - show onboarding
      Get.offNamed(Routes.ONBOARDING);
    } else if (!isLoggedIn) {
      // Returning user but not logged in - go to login
      Get.offNamed(Routes.LOGIN);
    } else if (!profileCompleted) {
      // Logged in but profile not completed - go to profile setup
      Get.offNamed(Routes.PROFILE_SCREEN);
    } else {
      // Fully authenticated user with complete profile - go to home
      Get.offNamed(Routes.HOME);
    }
  }

}
