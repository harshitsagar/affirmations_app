import 'package:get/get.dart';

import '../controllers/restore_controller.dart';

class RestoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RestoreController>(
      () => RestoreController(),
    );
  }
}
