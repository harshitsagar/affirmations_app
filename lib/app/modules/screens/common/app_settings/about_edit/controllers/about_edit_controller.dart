import 'package:affirmations_app/app/modules/screens/common/app_settings/settings/controllers/settings_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AboutEditController extends GetxController {
  final nameController = TextEditingController();
  final emailController = TextEditingController();

  final RxString selectedAgeGroup = ''.obs;
  final RxString selectedGender = ''.obs;

  final settingsController = Get.find<SettingsController>();
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    // Prefill from local or controller
    nameController.text = box.read('user_name')?.toString() ?? settingsController.name.value;
    emailController.text = box.read('user_email')?.toString() ?? settingsController.email.value;
    selectedAgeGroup.value = box.read('user_age')?.toString() ?? settingsController.age.value;
    selectedGender.value = box.read('user_gender')?.toString() ?? settingsController.gender.value;
  }

  void selectAgeGroup(String ageGroup) {
    selectedAgeGroup.value = selectedAgeGroup.value == ageGroup ? '' : ageGroup;
  }

  void selectGender(String gender) {
    selectedGender.value = selectedGender.value == gender ? '' : gender;
  }

  void saveDetails() {
    final name = nameController.text.trim();
    final email = emailController.text.trim();

    if (name.isEmpty) {
      Get.snackbar('Validation', 'Name is required',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.white, colorText: Colors.black);
      return;
    }

    if (email.isNotEmpty && !GetUtils.isEmail(email)) {
      Get.snackbar('Validation', 'Please enter a valid email',
          snackPosition: SnackPosition.TOP, backgroundColor: Colors.white, colorText: Colors.black);
      return;
    }

    // Save to local storage
    box.write('user_name', name);
    box.write('user_email', email);
    box.write('user_age', selectedAgeGroup.value);
    box.write('user_gender', selectedGender.value);

    // Update settings page
    settingsController.name.value = name;
    settingsController.email.value = email;
    settingsController.age.value = selectedAgeGroup.value;
    settingsController.gender.value = selectedGender.value;

    Get.back();
  }

  @override
  void onClose() {
    nameController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
