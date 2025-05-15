import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/themeListModel.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppThemesController extends GetxController {

  final RxList<ThemeListModelData> themeList = <ThemeListModelData>[].obs;
  final Rx<ThemeListModelData?> selectedTheme = Rx<ThemeListModelData?>(null);
  final loadingStatus = LoadingStatus.loading.obs;
  final isPremium = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchThemes();
    checkPremiumStatus();
  }

  Future<void> checkPremiumStatus() async {
    // Implement your premium status check logic here
    // For example:
    // isPremium.value = LocalStorage.prefs.getBool('isPremium') ?? false;
    isPremium.value = false; // Default to false, update with actual check
  }

  Future<void> fetchThemes() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.listTheme,
        {},
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response.data["code"] == 100) {
        final model = ThemeListModel.fromJson(response.data);
        themeList.assignAll(model.data ?? []);

        // Set default theme if available
        if (themeList.isNotEmpty) {
          final savedTheme = LocalStorage.prefs.read('selectedTheme');
          if (savedTheme != null) {
            final savedThemeData = ThemeListModelData.fromJson(savedTheme);
            final currentTheme = themeList.firstWhereOrNull(
                    (theme) => theme.sId == savedThemeData.sId
            );
            if (currentTheme != null) {
              selectedTheme(currentTheme);
            } else {
              selectedTheme(themeList.firstWhereOrNull(
                      (theme) => theme.aspect == 'free'
              ));
            }
          } else {
            selectedTheme(themeList.firstWhereOrNull(
                    (theme) => theme.aspect == 'free'
            ));
          }
        }
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to fetch themes: ${e.toString()}');
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  void selectTheme(ThemeListModelData theme) {
    if (isPremium.value || theme.aspect == 'free') {
      selectedTheme(theme);
      // Save selected theme to local storage
      LocalStorage.prefs.write('selectedTheme', theme.toJson());
    } else {
      Get.toNamed(Routes.SUBSCRIPTION_SCREEN);
    }
  }

  Future<void> saveTheme() async {
    if (selectedTheme.value == null) {
      AppConstants.showSnackbar(
        headText: 'Error',
        content: 'Please select a theme first',
        position: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "selectedTheme": selectedTheme.value?.sId,
        },
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response["code"] == 100) {
        // Save theme to local storage
        LocalStorage.prefs.write('selectedTheme', selectedTheme.value?.toJson());

        AppConstants.showSnackbar(
          headText: 'Success',
          content: 'Theme saved successfully',
          position: SnackPosition.BOTTOM,
        );

        // Navigate back twice if needed (once for theme screen, once for settings)
        if (Get.previousRoute == Routes.SETTINGS) {
          Get.until((route) => route.settings.name == Routes.SETTINGS);
        } else {
          Get.back();
        }
      } else {
        throw Exception(response["message"] ?? "Failed to save theme");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: 'Error',
        content: 'Failed to save theme: ${e.toString()}',
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  // // Method to update text colors when API is available
  // void updateTextColors(List<Color> colors) {
  //   themeTextColors.clear();
  //   themeTextColors.addAll(colors);
  //   update();
  // }

}