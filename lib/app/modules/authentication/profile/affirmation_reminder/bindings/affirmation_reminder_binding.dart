import 'package:get/get.dart';

import '../controllers/affirmation_reminder_controller.dart';

class AffirmationReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AffirmationReminderController>(
      () => AffirmationReminderController(),
    );
  }
}
