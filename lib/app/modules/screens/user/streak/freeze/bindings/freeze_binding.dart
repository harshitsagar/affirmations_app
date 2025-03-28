import 'package:get/get.dart';

import '../controllers/freeze_controller.dart';

class FreezeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FreezeController>(
      () => FreezeController(),
    );
  }
}
