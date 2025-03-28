import 'package:get/get.dart';

import '../controllers/journal_reminder_controller.dart';

class JournalReminderBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<JournalReminderController>(
      () => JournalReminderController(),
    );
  }
}
