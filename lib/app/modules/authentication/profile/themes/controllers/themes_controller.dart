import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/themeListModel.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ThemesController extends GetxController {

  final RxList<ThemeListModelData> themeList = <ThemeListModelData>[].obs;
  final RxList<ThemeListModelData> freeThemeList = <ThemeListModelData>[].obs;
  final selectedTheme = Rx<ThemeListModelData?>(null);
  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    fetchThemes();
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

        // Filter free themes
        freeThemeList.assignAll(
            themeList.where((theme) => theme.aspect == 'free').toList()
        );

        // Set default theme from free themes if available
        if (freeThemeList.isNotEmpty) {
          final savedTheme = LocalStorage.prefs.read('selectedTheme');
          if (savedTheme != null) {
            final savedThemeData = ThemeListModelData.fromJson(savedTheme);
            final currentTheme = freeThemeList.firstWhereOrNull(
                    (theme) => theme.sId == savedThemeData.sId
            );
            if (currentTheme != null) {
              selectedTheme(currentTheme);
            } else {
              selectedTheme(freeThemeList.first);
            }
          } else {
            selectedTheme(freeThemeList.first);
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
    selectedTheme(theme);
    // Save selected theme to local storage
    LocalStorage.prefs.write('selectedTheme', theme.toJson());
  }

  Future<void> saveSelectedTheme() async {
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
        ApiConstants.editProfile, // Make sure this constant is defined
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
        ThemeService.applyTheme(selectedTheme.value);

        AppConstants.showSnackbar(
          headText: 'Success',
          content: 'Theme saved successfully',
          position: SnackPosition.BOTTOM,
        );

        // Navigate to next screen
        Get.offAllNamed(Routes.JOURNAL1);
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

  // Get the current theme from local storage
  static ThemeListModelData? getCurrentTheme() {
    final themeData = LocalStorage.prefs.read('selectedTheme');
    return themeData != null ? ThemeListModelData.fromJson(themeData) : null;
  }

}


