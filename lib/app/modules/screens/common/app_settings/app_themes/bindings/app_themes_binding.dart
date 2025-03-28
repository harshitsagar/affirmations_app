import 'package:get/get.dart';

import '../controllers/app_themes_controller.dart';

class AppThemesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AppThemesController>(
      () => AppThemesController(),
    );
  }
}
