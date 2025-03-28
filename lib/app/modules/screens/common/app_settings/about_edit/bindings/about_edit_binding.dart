import 'package:get/get.dart';

import '../controllers/about_edit_controller.dart';

class AboutEditBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutEditController>(
      () => AboutEditController(),
    );
  }
}
