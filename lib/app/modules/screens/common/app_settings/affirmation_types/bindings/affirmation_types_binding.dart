import 'package:get/get.dart';

import '../controllers/affirmation_types_controller.dart';

class AffirmationTypesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AffirmationTypesController>(
      () => AffirmationTypesController(),
    );
  }
}
