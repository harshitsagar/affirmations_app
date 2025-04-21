import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';

class FavoritesController extends GetxController {
  final favoriteAffirmations = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      favoriteAffirmations.assignAll(Get.arguments as List<String>);
    }
  }

  void removeFavorite(String affirmation) {
    favoriteAffirmations.remove(affirmation);

    // Get both controllers
    final homeController = Get.find<HomeController>();
    final myListController = Get.find<MyListController>();

    // Update both controllers
    homeController.favoriteAffirmations.remove(affirmation);
    myListController.favoriteAffirmations.remove(affirmation);

    // Force updates
    homeController.update();
    myListController.update(); // This will trigger the UI update in MyListView

    // If you're using GetStorage for favorites, update storage here
    // _storage.write('favorites', homeController.favoriteAffirmations);
  }

  void shareAffirmation(String affirmation) {
    Get.lazyPut(() => ShareScreenController());
    Get.bottomSheet(
      ShareScreenView(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }
}