import 'package:affirmations_app/app/modules/screens/onboarding/views/onboarding_view.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onReady() {
    super.onReady();

    Future.delayed(Duration(seconds: 2), () {
      Get.off(() => OnboardingView());
    });

  }

}
