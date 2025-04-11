import 'dart:io';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {

  final box = GetStorage();

  // User data
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString age = ''.obs;
  final RxString gender = ''.obs;

  @override
  void onInit() {
    super.onInit();

    // Load from local storage, else use defaults
    name.value = box.read('user_name')?.toString() ?? 'John Doe';
    email.value = box.read('user_email')?.toString() ?? 'john@example.com';
    age.value = box.read('user_age')?.toString() ?? '25';
    gender.value = box.read('user_gender')?.toString() ?? '';
  }

  void handleSettingTap(String title) {
    switch (title) {
      case 'Affirmations Types':
      // Navigate or handle logic
        Get.toNamed(Routes.AFFIRMATION_TYPES);
        break;
      case 'Reminders':
        Get.toNamed(Routes.REMINDERS);
        break;
      case 'App Theme':
        break;
      case 'Refer a Friend':
        break;
      case 'Leave us a Review':
        Get.dialog(
          CustomPopupDialog(
            title: 'Enjoying the App?',
            description:
            'Leave us a review and help us improve\nyour experience! If you have any issues\nor queries, feel free to reach out\nthrough the "Contact Us".',
            primaryButtonText: 'Yes',
            secondaryButtonText: 'No',
            onPrimaryPressed: () {
              _redirectToStore();
              Get.back();
            },
            onSecondaryPressed: () => Get.back(),
          ),
          barrierDismissible: false,
        );
        break;
      case 'About Us':
        break;
      case 'Terms & Conditions':
        break;
      case 'Privacy Policy':
        break;
      case 'Contact Admin':
        break;
      case 'FAQs':
        break;
      case 'Logout':
        break;
      case 'Delete':
        break;
      default:
        break;
    }
  }

  Future<void> _redirectToStore() async {

    String url = '';

    // Replace with your app's actual store links...
    if (Platform.isAndroid) {
      url = 'https://play.google.com/store/apps/details?id=com.example.app'; // Replace with your Android package name
    } else if (Platform.isIOS) {
      url = 'https://apps.apple.com/app/id123456789'; // Replace with your iOS App Store ID
    }

    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      Get.snackbar(
        'Error',
        'Could not launch the store link.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

}
