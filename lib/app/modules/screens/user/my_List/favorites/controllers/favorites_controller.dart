import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/favList_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';

class FavoritesController extends GetxController {

  final loadingStatus = LoadingStatus.loading.obs;

  final _favoriteList = <Data>[].obs;
  List<Data> get favoriteList => _favoriteList;

  @override
  void onInit() {
    super.onInit();
    fetchFavList();
  }

  Future<void> fetchFavList() async {
    try {
      loadingStatus(LoadingStatus.loading);
      var accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.favList,
        {},
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        final model = FavoriteListModel.fromJson(response.data);
        _favoriteList.assignAll(model.data ?? []);

        // Sync with HomeController
        if (Get.isRegistered<HomeController>()) {
          final homeController = Get.find<HomeController>();
          homeController.likedAffirmationIds.assignAll(
              _favoriteList.where((item) => item.isLiked == true).map((item) => item.sId ?? "").toList()
          );
        }
      }
    } catch (e) {
      // Error handling
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  // Add this method to handle like/unlike
  Future<void> toggleFavorite(String affirmationRef, bool isCurrentlyLiked) async {
    try {
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.likeAffirmation,
        {
          "affirmationRef": affirmationRef,
          "isLiked": !isCurrentlyLiked,
        },
        {
          'Authorization': accessToken,
          'Content-Type': 'application/json',
        },
      );

      if (response.data["code"] == 100) {
        // Refresh the list
        await fetchFavList();

        // Also update the HomeController if it's in memory
        if (Get.isRegistered<HomeController>()) {
          final homeController = Get.find<HomeController>();
          if (isCurrentlyLiked) {
            homeController.likedAffirmationIds.remove(affirmationRef);
          } else {
            homeController.likedAffirmationIds.add(affirmationRef);
          }
        }
      } else {
        throw Exception(response.data["message"] ?? "Failed to update favorite status");
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to update favorite: ${e.toString()}',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void removeFavorite(String affirmationRef) async {
    try {
      loadingStatus(LoadingStatus.loading);

      // Optimistic update
      _favoriteList.removeWhere((item) => item.sId == affirmationRef);
      update();

      await toggleFavorite(affirmationRef, true);

      // Sync with HomeController
      if (Get.isRegistered<HomeController>()) {
        Get.find<HomeController>().likedAffirmationIds.remove(affirmationRef);
      }
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
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