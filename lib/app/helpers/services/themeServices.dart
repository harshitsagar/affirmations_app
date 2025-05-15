import 'package:affirmations_app/app/modules/authentication/profile/themes/controllers/themes_controller.dart';
import 'package:flutter/material.dart';
import 'package:affirmations_app/app/data/models/themeListModel.dart';
import 'package:get/get.dart';

class ThemeService {

  static BoxDecoration getBackgroundDecoration(ThemeListModelData? theme) {
    if (theme == null || theme.backgroundGradient == null) {
      return const BoxDecoration(
        color: Colors.white,
      );
    }

    return BoxDecoration(
      gradient: LinearGradient(
        colors: theme.backgroundGradient!
            .map((color) => Color(int.parse(color.replaceFirst('#', '0xFF'))))
            .toList(),
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ),
    );
  }

  static ThemeData getThemeData(ThemeListModelData? theme) {

    return ThemeData.light();

    // return ThemeData(
    //   primaryColor: Color(int.parse(theme.primaryColor!.replaceFirst('#', '0xFF'))),
    //   colorScheme: ColorScheme.light(
    //       primary: Color(int.parse(theme.primaryColor!.replaceFirst('#', '0xFF'))),
    //       secondary: Color(int.parse(theme.secondaryColor!.replaceFirst('#', '0xFF')))),
    // );
    // // Add other theme customizations as needed
    // // );
  }

  static void applyTheme(ThemeListModelData? theme) {
    if (theme != null) {
      // Save to GetX for immediate access

      Get.find<ThemesController>().selectedTheme(theme);
      // Change the theme
      // Get.changeTheme(getThemeData(theme));
      // Force UI update
      Get.forceAppUpdate();
    }
  }
}