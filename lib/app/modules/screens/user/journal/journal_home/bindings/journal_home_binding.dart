import 'package:get/get.dart';

import '../controllers/journal_home_controller.dart';

class JournalHomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalHomeController>(
      () => JournalHomeController(),
    );
  }
}
