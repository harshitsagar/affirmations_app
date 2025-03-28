import 'package:get/get.dart';

import '../controllers/subscription_screen_controller.dart';

class SubscriptionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionScreenController>(
      () => SubscriptionScreenController(),
    );
  }
}
