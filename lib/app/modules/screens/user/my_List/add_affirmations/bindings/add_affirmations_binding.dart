import 'package:get/get.dart';

import '../controllers/add_affirmations_controller.dart';

class AddAffirmationsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddAffirmationsController>(
      () => AddAffirmationsController(),
    );
  }
}
