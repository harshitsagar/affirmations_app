import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AffirmationsController extends GetxController {
  final areas = <String>[
    'Body Positivity',
    'Self-Love',
    'Confidence',
    'Gratitude',
    'Happiness',
    'Abundance',
    'Manifestation'
  ].obs;

  final selectedAreas = <String>[].obs;

  void toggleAreaSelection(String area) {
    if (selectedAreas.contains(area)) {
      selectedAreas.remove(area);
    } else {
      selectedAreas.add(area);
    }
  }

  bool get isSelectionValid => selectedAreas.length >= 3;

  void showSelectionError() {
    Get.snackbar(
      'Selection Required',
      'Please select at least 3 areas',
      snackPosition: SnackPosition.TOP,
      duration: const Duration(seconds: 2),
    );
  }

  void navigateToThemeScreen() {
    if (!isSelectionValid) {
      showSelectionError();
      return;
    }
    Get.toNamed(Routes.THEMES);
  }
}