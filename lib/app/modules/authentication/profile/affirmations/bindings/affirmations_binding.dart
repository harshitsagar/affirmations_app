import 'package:get/get.dart';

import '../controllers/affirmations_controller.dart';

class AffirmationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AffirmationsController>(
      () => AffirmationsController(),
    );
  }
}
