import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../../../../../data/api_provider.dart';
import '../../../../../../helpers/constants/api_constants.dart';
import '../../../../../../helpers/services/local_storage.dart';

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
    final myListController = Get.find<MyListController>();
    final list = myListController.lists.firstWhereOrNull((e) => e.name == listName.value);

    if (list != null && list.affirmations != null) {
      final affirmationNames = list.affirmations!
          .map((a) => a['name'].toString())
          .toList();
      affirmations.assignAll(affirmationNames);
    } else {
      affirmations.clear(); // No affirmations found for this list
    }
  }



  void addAffirmation(String text) async {
    if (text.trim().isEmpty) {
      Get.snackbar("Error", "Affirmation text cannot be empty.");
      return;
    }

    if (text.length > maxCharacters) {
      Get.snackbar("Error", "Affirmation cannot exceed $maxCharacters characters.");
      return;
    }

    try {
      final accessToken = LocalStorage.getUserAccessToken();
      final myListController = Get.find<MyListController>();
      final myListRef = myListController.listNameToIdMap[listName.value];

      if (myListRef == null) {
        Get.snackbar("Error", "List reference not found.");
        return;
      }

      final response = await APIProvider().postAPICall(
        ApiConstants.addAffirmation,
        {
          "name": text,
          "myListRef": myListRef,
        },
        {
          "Authorization": accessToken,
          "Content-Type": "application/json",
        },
      );

      final res = response.data;

      if (res["code"] == 100) {
        affirmations.add(text);
        // Update the corresponding list in MyListController
        final list = myListController.lists.firstWhereOrNull((e) => e.name == listName.value);
        if (list != null) {
          list.affirmations.add({"name": text});
          list.totalAffirmation += 1;
          myListController.update(); // Notify the UI
        }
        _saveAffirmations();
        Get.snackbar("Success", "Affirmation added successfully.");
      } else {
        Get.snackbar("Error", res["message"] ?? "Failed to add affirmation.");
      }
    } catch (e) {
      print("Add Affirmation Error: $e");
      Get.snackbar("Error", "Something went wrong while adding affirmation.");
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

      myListController.removeAffirmationFromList(listName.value, removedAffirmation);

      if (myListController.favoriteAffirmations.contains(removedAffirmation)) {
        myListController.favoriteAffirmations.remove(removedAffirmation);
        Get.find<HomeController>().favoriteAffirmations.remove(removedAffirmation);
      }

      _saveAffirmations();
      myListController.update();
      update();
    }
  }

  void updateCharacterCount(int count) {
    characterCount.value = count;
  }

  void _saveAffirmations() {
    // _storage.write('${listName.value}_affirmations', affirmations.toList());
    //
    // final myListController = Get.find<MyListController>();
    // myListController.customListsAffirmations[listName.value] = List<String>.from(affirmations);
    // myListController.update();
  }

  void toggleAffirmationFavorite(int index) {
    if (index >= 0 && index < affirmations.length) {
      final affirmation = affirmations[index];
      final myListController = Get.find<MyListController>();
      final homeController = Get.find<HomeController>();

      if (myListController.favoriteAffirmations.contains(affirmation)) {
        myListController.favoriteAffirmations.remove(affirmation);
        homeController.favoriteAffirmations.remove(affirmation);
      } else {
        myListController.favoriteAffirmations.add(affirmation);
        homeController.favoriteAffirmations.add(affirmation);
      }

      myListController.update();
      homeController.update();
      update();
    }
  }

  void shareAffirmation(String affirmation) {
    Get.lazyPut(() => ShareScreenController());

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
