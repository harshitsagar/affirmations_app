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
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';

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
      var accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.favList,
        {},
        {
          'Authorization': accessToken,
        },
      );

      if (response.data["code"] == 100) {
        final model = FavoriteListModel.fromJson(response.data);
        _favoriteList.assignAll(model.data ?? []);
        print(_favoriteList.value);
      } else {
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"] ?? "An error occurred",
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
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
        // Update the local list immediately for better UX
        _favoriteList.removeWhere((item) => item.sId == affirmationRef);

        // Optional: Show feedback
        Get.snackbar(
          'Success',
          isCurrentlyLiked ? 'Removed from favorites' : 'Added to favorites',
          snackPosition: SnackPosition.BOTTOM,
        );

        // // Optional: Refresh the list from server
        // await fetchFavList();

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

  // Update your existing removeFavorite method to use toggleFavorite
  void removeFavorite(String affirmationRef) async {
    loadingStatus(LoadingStatus.loading);
    await toggleFavorite(affirmationRef, true);
    loadingStatus(LoadingStatus.completed);
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