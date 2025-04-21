import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AddAffirmationsController extends GetxController {
  final listName = ''.obs;
  final affirmations = <String>[].obs;
  final _storage = GetStorage();
  final characterCount = 0.obs;
  final int maxCharacters = 300;

  @override
  void onInit() {
    super.onInit();
    listName.value = Get.arguments['listName'] ?? '';
    _loadAffirmations();
  }

  void _loadAffirmations() {
    // First try loading from MyListController's unified storage
    final myListController = Get.find<MyListController>();
    if (myListController.customListsAffirmations.containsKey(listName.value)) {
      affirmations.assignAll(myListController.customListsAffirmations[listName.value]!);
    } else {
      // Fallback to individual list storage
      final rawData = _storage.read('${listName.value}_affirmations');
      if (rawData != null && rawData is List) {
        affirmations.assignAll(rawData.cast<String>());
        // Initialize in MyListController if missing
        myListController.customListsAffirmations[listName.value] = List<String>.from(affirmations);
      }
    }
  }

  void addAffirmation(String text) {
    if (text.isNotEmpty && text.length <= maxCharacters) {
      affirmations.add(text);
      _saveAffirmations(); // This already updates MyListController as well
    }
  }

  void showDeleteConfirmation(int index) {
    if (index < 0 || index >= affirmations.length) return;

    final affirmationText = affirmations[index];
    final truncatedText = affirmationText.length > 30
        ? '${affirmationText.substring(0, 30)}...'
        : affirmationText;

    Get.dialog(
      CustomPopupDialog(
        title: 'Delete Affirmation',
        description: 'Are you sure you want to delete this affirmation from your list?',
        primaryButtonText: 'Yes',
        secondaryButtonText: 'No',
        onPrimaryPressed: () {
          Get.back();
          _performDelete(index);
        },
        onSecondaryPressed: () => Get.back(),
        descriptionWidth: 300.w,
      ),
      barrierDismissible: false,
    );
  }

  void _performDelete(int index) {
    if (index >= 0 && index < affirmations.length) {
      final removedAffirmation = affirmations.removeAt(index);
      final myListController = Get.find<MyListController>();

      // Remove from current list
      myListController.removeAffirmationFromList(listName.value, removedAffirmation);

      // Remove from favorites if needed
      if (myListController.favoriteAffirmations.contains(removedAffirmation)) {
        myListController.favoriteAffirmations.remove(removedAffirmation);
        Get.find<HomeController>().favoriteAffirmations.remove(removedAffirmation);
      }

      // Update storage and UI
      _saveAffirmations();
      myListController.update();
      update();

    }
  }

  void updateCharacterCount(int count) {
    characterCount.value = count;
  }

  void _saveAffirmations() {
    // Save to both storage locations for redundancy
    _storage.write('${listName.value}_affirmations', affirmations.toList());

    // Update the unified storage via MyListController
    final myListController = Get.find<MyListController>();
    myListController.customListsAffirmations[listName.value] = List<String>.from(affirmations);
    myListController.update();
  }

  // In add_affirmations_controller.dart
  void toggleAffirmationFavorite(int index) {
    if (index >= 0 && index < affirmations.length) {
      final affirmation = affirmations[index];
      final myListController = Get.find<MyListController>();
      final homeController = Get.find<HomeController>();

      if (myListController.favoriteAffirmations.contains(affirmation)) {
        // Remove from favorites
        myListController.favoriteAffirmations.remove(affirmation);
        homeController.favoriteAffirmations.remove(affirmation);
      } else {
        // Add to favorites
        myListController.favoriteAffirmations.add(affirmation);
        homeController.favoriteAffirmations.add(affirmation);
      }

      // Force UI updates
      myListController.update();
      homeController.update();
      update(); // This is crucial - updates the current controller
    }
  }

  void shareAffirmation(String affirmation) {
    Get.lazyPut(() => ShareScreenController());

    // Pass the specific affirmation to share
    Get.bottomSheet(
      ShareScreenView(affirmation: affirmation),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

  bool isAffirmationFavorite(String affirmation) {
    final myListController = Get.find<MyListController>();
    return myListController.favoriteAffirmations.contains(affirmation);
  }
}