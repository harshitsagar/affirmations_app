import 'package:affirmations_app/app/helpers/services/purchase_service.dart';
import 'package:get/get.dart';
import '../controllers/subscription_screen_controller.dart';

class SubscriptionScreenBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SubscriptionScreenController>(
      () => SubscriptionScreenController(),
    );
    Get.lazyPut(() => PurchaseService());
  }
}
