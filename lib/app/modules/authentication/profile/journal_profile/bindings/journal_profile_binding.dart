import 'package:get/get.dart';

import '../controllers/journal_profile_controller.dart';

class JournalProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalProfileController>(
      () => JournalProfileController(),
    );
  }
}
