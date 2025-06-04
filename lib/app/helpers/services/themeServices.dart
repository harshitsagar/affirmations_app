import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/models/themeListModel.dart';
import 'package:affirmations_app/app/data/models/user_model.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ThemeService {
  static ThemeListModelData? get currentTheme {
    // First try to get from user data if available
    final user = LocalStorage.getUserDetailsData();
    if (user?.currentTheme != null) {
      return ThemeListModelData(
        sId: user!.currentTheme!.id,
        backgroundGradient: user.currentTheme!.backgroundGradient,
        name: user.currentTheme!.name,
        aspect: user.currentTheme!.aspect,
      );
    }

    // Fallback to local storage
    final themeData = LocalStorage.prefs.read('selectedTheme');
    if (themeData != null) return ThemeListModelData.fromJson(themeData);

    // Fallback to default theme if nothing is selected
    return getDefaultTheme();
  }

  static ThemeListModelData getDefaultTheme() {
    return ThemeListModelData(
      sId: "6820df0309f40900139c9e2d",
      backgroundGradient: ["#FFF6E3", "#FFCCEA", "#CDC1FF", "#FC938F"],
      name: "sunflower",
      aspect: "default",
      deleted: false,
      primaryColor: "#123456",
      secondaryColor: "#123456",
    );
  }

  static BoxDecoration getBackgroundDecoration() {
    final theme = currentTheme;
    return theme?.aspect == 'default'
        ? BoxDecoration(
          image: DecorationImage(image: AssetImage(bgImage), fit: BoxFit.cover),
        )
        : BoxDecoration(
          gradient: LinearGradient(
            colors:
                theme?.backgroundGradient
                    ?.map(
                      (color) =>
                          Color(int.parse(color.replaceFirst('#', '0xFF'))),
                    )
                    .toList() ??
                getDefaultTheme().backgroundGradient!
                    .map(
                      (color) =>
                          Color(int.parse(color.replaceFirst('#', '0xFF'))),
                    )
                    .toList(),
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        );
  }

  static void applyTheme(ThemeListModelData theme) {
    // Save to local storage
    LocalStorage.prefs.write('selectedTheme', theme.toJson());
    Get.forceAppUpdate(); // Force UI to refresh with new theme
  }

  static void updateThemeFromUserData(User user) {
    if (user.currentTheme != null) {
      final theme = ThemeListModelData(
        sId: user.currentTheme!.id,
        backgroundGradient: user.currentTheme!.backgroundGradient,
        name: user.currentTheme!.name,
        aspect: user.currentTheme!.aspect,
      );
      applyTheme(theme);
    }
  }
}
