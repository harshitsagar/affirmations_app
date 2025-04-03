import 'package:get/get.dart';

class ProfileScreenController extends GetxController {

  RxString selectedAgeGroup = ''.obs;
  RxString selectedGender = ''.obs;

  void selectAgeGroup(String age) {
    selectedAgeGroup.value = age;
  }

  void selectGender(String gender) {
    selectedGender.value = gender;
  }

}