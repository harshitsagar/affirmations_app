import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/modules/screens/common/app_settings/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AboutEditController extends GetxController {

  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final RxString selectedAgeGroup = ''.obs;
  final RxString selectedGender = ''.obs;

  final RxBool isLoading = false.obs;

  final SettingsController settingsController = Get.find<SettingsController>();

  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Initialize fields from settings controller
    nameController.text = settingsController.name.value;
    emailController.text = settingsController.email.value;
    selectedAgeGroup.value = settingsController.age.value;
    selectedGender.value = settingsController.gender.value;
  }

  int? _getAgeGroupValue(String ageGroup) {
    switch (ageGroup) {
      case '18 or Under': return 1;
      case '19 - 24': return 2;
      case '25 - 34': return 3;
      case '35 - 44': return 4;
      case '45 - 54': return 5;
      case '55 - 64': return 6;
      case '65 or Older': return 7;
      default: return null;
    }
  }

  int? _getGenderValue(String gender) {
    switch (gender) {
      case 'Female': return 1;
      case 'Male': return 2;
      case 'Non-Binary': return 3;
      case 'Prefer not to say': return 4;
      default: return null;
    }
  }

  void selectAgeGroup(String ageGroup) {
    selectedAgeGroup.value = selectedAgeGroup.value == ageGroup ? '' : ageGroup;
    print(
      '*******Selected Age Group: ${selectedAgeGroup.value}',
    );
  }

  void selectGender(String gender) {
    selectedGender.value = selectedGender.value == gender ? '' : gender;
    print(
      '**********Selected Gender : ${selectedGender.value}',
    );
  }

  void saveDetails() async {
    final name = nameController.text.toString();
    var accessToken = LocalStorage.getUserAccessToken();

    if (name.isEmpty) {
      Get.snackbar('Validation', 'Name is required',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black);
      return;
    }

    isLoading(true);

    try {

      // Call API using formDataPostAPICall
      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "name": name,
          "ageGroup": _getAgeGroupValue(selectedAgeGroup.value),
          "gender": _getGenderValue(selectedGender.value),
        },
        {
          'Authorization': accessToken.toString(),
        },
      );

      // Properly handle the response (it's already decoded)
      if (response["code"] == 100) {
        // Update local state
        settingsController.name.value = name;
        settingsController.age.value = selectedAgeGroup.value;
        settingsController.gender.value = selectedGender.value;

        // Refresh from server
        await settingsController.fetchUserProfile();
        Get.back();
        Get.snackbar(
          'Success',
          'Profile updated successfully',
          snackPosition: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception(response["message"]?.toString() ?? "Failed to update profile");
      }
    } catch (e) {
      Get.snackbar(
          'Error',
          'Failed to update profile: ${e.toString()}',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.white,
          colorText: Colors.black
      );
    } finally {
      isLoading(false);
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    // emailController.dispose();
    super.onClose();
  }
}
