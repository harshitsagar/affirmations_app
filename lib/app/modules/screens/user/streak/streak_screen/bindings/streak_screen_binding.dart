import 'package:get/get.dart';

import '../controllers/streak_screen_controller.dart';

class StreakScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StreakScreenController>(
      () => StreakScreenController(),
    );
  }
}
