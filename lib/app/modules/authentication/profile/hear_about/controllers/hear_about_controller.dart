import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class HearAboutController extends GetxController {
  // Mapping of options to their backend IDs
  final Map<String, int> optionIds = {
    'App Store': 1,
    'Google Play': 2,
    'Tiktok': 3,
    'Instagram': 4,
    'Friend/ Family': 5,
    'Web Search': 6,
    'Email': 7,
    'Others': 8,
  };

  final options = <String>[
    'App Store',
    'Google Play',
    'Tiktok',
    'Instagram',
    'Friend/ Family',
    'Web Search',
    'Email',
    'Others'
  ].obs;

  final selectedOptions = <String>[].obs;
  final isLoading = false.obs;

  void toggleOptionSelection(String option) {
    if (selectedOptions.contains(option)) {
      selectedOptions.remove(option);
    } else {
      selectedOptions.add(option);
    }
  }

  // Convert selected options to their backend IDs
  List<int> get selectedOptionIds => selectedOptions
      .map((option) => optionIds[option] ?? 0)
      .where((id) => id != 0)
      .toList();

  Future<void> saveHearAboutOptions() async {
    if (selectedOptions.isEmpty) {
      AppConstants.showSnackbar(
        headText: 'Selection Required',
        content: 'Please select at least one option',
        position: SnackPosition.TOP,
      );
      return;
    }

    try {
      isLoading(true);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile, // Or use a dedicated endpoint
        {
          "heardFrom": selectedOptionIds..sort(), // Send list of selected IDs
        },
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response["code"] == 100) {
        await LocalStorage.setProfileCompleted();
        Get.toNamed(Routes.SUBSCRIPTION_SCREEN);
      } else {
        throw Exception(response["message"] ?? "Failed to save selection");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to save selection: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }
}