import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/affirmationTypesModel.dart';
import 'package:affirmations_app/app/data/models/user_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AffirmationsController extends GetxController {

  final loadingStatus = LoadingStatus.loading.obs;
  final affirmationTypes = <AffirmationTypesModelData>[].obs;
  final selectedTypes = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchAffirmationTypes();
  }

  Future<void> fetchAffirmationTypes() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.affirmationCatergoryList, // Make sure this constant is defined
        {},
        {
          'Authorization': accessToken,
        },
      );

      if (response.data["code"] == 100) {
        final model = AffirmationTypesModel.fromJson(response.data);
        affirmationTypes.assignAll(model.data ?? []);
      } else {
        throw Exception(response.data["message"] ?? "Failed to fetch types");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  void toggleSelection(String typeId) {
    if (selectedTypes.contains(typeId)) {
      selectedTypes.remove(typeId);
    } else {
      selectedTypes.add(typeId);
    }
  }

  bool get isValidSelection => selectedTypes.length >= 3;

  void showError() {
    AppConstants.showSnackbar(
      headText: 'Selection Required',
      content: 'Please select at least 3 affirmation types',
      position: SnackPosition.TOP,
    );
  }

  Future<void> saveSelections() async {
    if (!isValidSelection) {
      showError();
      return;
    }

    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();
      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile, // Make sure this constant is defined
        {
          "areasToWork": selectedTypes.toList(),
        },
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response["code"] == 100) {
        // // // Update local storage with new data
        // final updatedUser = User.fromJson(response["data"]);
        // LocalStorage.setUserDetailsData(userDetailsData: updatedUser);
        AppConstants.showSnackbar(
          headText: "Success",
          content: "Preferences saved successfully",
          position: SnackPosition.BOTTOM,
        );
        Get.toNamed(Routes.THEMES); // Navigate to themes after successful save
      } else {
        throw Exception(response["message"] ?? "Failed to save selections");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to save selections: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    }
    finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

}