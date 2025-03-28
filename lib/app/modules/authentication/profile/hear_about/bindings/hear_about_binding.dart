import 'package:get/get.dart';

import '../controllers/hear_about_controller.dart';

class HearAboutBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HearAboutController>(
      () => HearAboutController(),
    );
  }
}
