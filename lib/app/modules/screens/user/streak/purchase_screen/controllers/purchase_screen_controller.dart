import 'package:affirmations_app/app/helpers/services/purchase_service.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:get/get.dart';
import '../../../../../../helpers/constants/purchase_constants.dart';

class PurchaseScreenController extends GetxController {

  final purchaseService = Get.find<PurchaseService>();
  final String type = Get.arguments['type'] ?? 'Freeze'; // 'Freeze' or 'Restore'
  final selectedPackage = RxInt(-1); // -1 means nothing selected initially

  String get productId {
    switch (selectedPackage.value) {
      case 0: return singlePurchaseId;
      case 1: return bundlePurchaseId;
      case 2: return completePurchaseId;
      default: throw Exception('Invalid package selected');
    }
  }

  @override
  void onInit() {
    super.onInit();
  }

  void selectPackage(int index) {
    selectedPackage.value = index;
  }

  void onCancelPressed() {
    Get.back();
  }

  void onPurchasePressed() {

    if (selectedPackage.value == -1) {
      Get.snackbar('Error', 'Please select a package');
      return;
    }

    purchaseService.purchaseProduct(
      productId,
      isFreeze: type == 'Freeze',
      isRestore: type == 'Restore',
    ).catchError((error) {
      Get.snackbar('Error', 'Purchase failed: $error');
    });

    final int freezeCount;
    final int restoreCount;

    switch(selectedPackage.value) {
      case 0: // Simple
        freezeCount = type == 'Freeze' ? 1 : 0;
        restoreCount = type == 'Restore' ? 1 : 0;
        break;
      case 1: // Bundle
        freezeCount = type == 'Freeze' ? 5 : 0;
        restoreCount = type == 'Restore' ? 5 : 0;
        break;
      case 2: // Complete
        freezeCount = 5;
        restoreCount = 5;
        break;
      default:
        freezeCount = 0;
        restoreCount = 0;
    }

    // Return the purchased items to the streak screen
    Get.back(result: {
      'freezeCount': freezeCount,
      'restoreCount': restoreCount,
    });
  }

  void onTermsPressed() {
    Get.to(() => const InfoPage(title: "Terms & Conditions"));
  }
}