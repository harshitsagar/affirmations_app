import 'package:get/get.dart';

import '../controllers/contact_admin_controller.dart';

class ContactAdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ContactAdminController>(
      () => ContactAdminController(),
    );
  }
}
