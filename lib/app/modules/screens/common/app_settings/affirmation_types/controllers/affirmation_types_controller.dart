import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AffirmationTypesController extends GetxController {

  final storage = GetStorage();

  // Mock custom lists (normally fetched from backend)
  final customLists = <String>[
    'My Favorites',
    'My List: Morning Routine',
    'My List: Night Routine',
  ];

  // Mock predefined lists
  final predefinedLists = <String>[
    'Body Positivity',
    'Self-Love',
    'Confidence',
    'Gratitude',
    'Happiness',
    'Abundance',

  ];

  // Combined list: custom lists come first
  late final allAffirmationTypes = <String>[
    ...customLists,
    ...predefinedLists,
  ].obs;

  final selectedTypes = <String>[].obs;

  void toggleSelection(String type) {
    if (selectedTypes.contains(type)) {
      selectedTypes.remove(type);
    } else {
      selectedTypes.add(type);
    }
  }

  bool get isValidSelection => selectedTypes.length >= 3;

  void showError() {
    Get.snackbar(
      'Selection Required',
      'Please select at least 3 affirmation types',
      snackPosition: SnackPosition.TOP,
    );
  }

  void saveSelections() {
    if (!isValidSelection) {
      showError();
      return;
    }

    // Save locally
    storage.write('selected_affirmation_types', selectedTypes.toList());

    // Placeholder for API call
    // TODO: Send selectedTypes to backend when API is available

    // Navigate to settings
    Get.offAllNamed(Routes.SETTINGS);
  }

  @override
  void onInit() {
    super.onInit();
    final saved = storage.read<List>('selected_affirmation_types');
    if (saved != null) {
      selectedTypes.assignAll(saved.cast<String>());
    }
  }
}
