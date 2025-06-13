import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/user_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:get/get.dart';

class ProfileScreenController extends GetxController {

  RxString selectedAgeGroup = ''.obs;
  RxString selectedGender = ''.obs;
  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    loadingStatus(LoadingStatus.completed);
  }

  void selectAgeGroup(String age) {
    selectedAgeGroup.value = age;
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

  int _getAgeGroupValue(String ageGroup) {
    switch (ageGroup) {
      case '18 or Under': return 1;
      case '19 - 24': return 2;
      case '25 - 34': return 3;
      case '35 - 44': return 4;
      case '45 - 54': return 5;
      case '55 - 64': return 6;
      case '65 or Older': return 7;
      default: return 0;
    }
  }

  int _getGenderValue(String gender) {
    switch (gender) {
      case 'Female': return 1;
      case 'Male': return 2;
      case 'Non-Binary': return 3;
      case 'Prefer not to say': return 4;
      default: return 0;
    }
  }

  Future<void> updateProfile() async {
    try {
      loadingStatus(LoadingStatus.loading);

      var accessToken = LocalStorage.getUserAccessToken();

      final userRef = LocalStorage.getUserDetailsData()?.id;
      if (userRef == null) throw Exception("User not logged in");

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "ageGroup": _getAgeGroupValue(selectedAgeGroup.value),
          "gender": _getGenderValue(selectedGender.value),
        },
        {
          'Authorization': accessToken.toString(),
        },
      );

      if (response["code"] == 100) {
        // // Update local storage with new data
        // final updatedUser = User.fromJson(response.data["data"]);
        // LocalStorage.setUserDetailsData(userDetailsData: updatedUser);
        AppConstants.showSnackbar(
          headText: "Success",
          content: "Profile updated successfully",
          position: SnackPosition.BOTTOM,
        );
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

}