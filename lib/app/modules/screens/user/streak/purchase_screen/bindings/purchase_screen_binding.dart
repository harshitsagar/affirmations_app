import 'package:get/get.dart';

import '../controllers/purchase_screen_controller.dart';

class PurchaseScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PurchaseScreenController>(
      () => PurchaseScreenController(),
    );
  }
}
