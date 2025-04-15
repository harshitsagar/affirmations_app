import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AppThemesController extends GetxController {
  final List<String> themeImages = [
    theme1,
    theme2,
    theme3,
    theme4,
    theme5,
    theme6,
    theme7,
    theme8,
    theme9,
  ];

  // List to track which themes are locked (index-based)
  final List<bool> lockedThemes = [
    false, // first theme is unlocked
    false, // second theme is unlocked
    false, // third theme is unlocked
    true,  // fourth theme is locked
    true,  // fifth theme is locked
    true,  // sixth theme is locked
    true,  // seventh theme is locked
    true,  // eighth theme is locked
    true,  // ninth theme is locked
  ];

  // Observable selected theme index
  var selectedTheme = 0.obs;

  // Track premium status
  var isPremium = false.obs;

  // Hardcoded text colors for each theme (can be replaced with API data later)
  final List<Color> themeTextColors = [
    Colors.black,
    Colors.black,
    Colors.black,
    Colors.white,
    Colors.white,
    Colors.white,
    Colors.black,
    Colors.black,
    Colors.white,
  ];

  @override
  void onInit() {
    super.onInit();
    isPremium.value = false;
  }

  void selectTheme(int index) {
    if (isPremium.value || !lockedThemes[index]) {
      selectedTheme.value = index;
      update(); // This triggers the UI to refresh
    } else {
      Get.toNamed(Routes.SUBSCRIPTION_SCREEN);
    }
  }

  void saveTheme() {
    print('Selected theme: ${selectedTheme.value}');
    Get.back();
  }

  // Method to update text colors when API is available
  void updateTextColors(List<Color> colors) {
    themeTextColors.clear();
    themeTextColors.addAll(colors);
    update();
  }
}