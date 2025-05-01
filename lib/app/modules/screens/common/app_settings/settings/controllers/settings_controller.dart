import 'dart:io';
import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/app_details_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:affirmations_app/app/widgets/detailsPage.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsController extends GetxController {

  final box = GetStorage();

  final _appDetails = Rx<AppData>(AppData());
  AppData get appDetails => _appDetails.value;

  final loadingStatus = LoadingStatus.loading.obs;

  // User data
  final RxString name = ''.obs;
  final RxString email = ''.obs;
  final RxString age = ''.obs;
  final RxString gender = ''.obs;
  
  @override
  void onInit() {
    super.onInit();

    fetchAppDetails();

    // Load from local storage, else use defaults
    name.value = box.read('user_name')?.toString() ?? 'John Doe';
    email.value = box.read('user_email')?.toString() ?? 'john@example.com';
    age.value = box.read('user_age')?.toString() ?? '25';
    gender.value = box.read('user_gender')?.toString() ?? '';
  }

  void fetchAppDetails() async {
    try {
      loadingStatus(LoadingStatus.loading);

      // Fetch the app details from the API.
      final response = await APIProvider().postAPICall(
        ApiConstants.appDetails,
        {},
        {},
      );

      if (response.data["code"] == 100) {
        _appDetails.value = AppData.fromJson(response.data["data"]);
      } else {
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  void handleSettingTap(String title) {
    switch (title) {
      case 'Affirmations Types':
        Get.toNamed(Routes.AFFIRMATION_TYPES);
        break;
      case 'Reminders':
        Get.toNamed(Routes.REMINDERS);
        break;
      case 'App Theme':
        Get.toNamed(Routes.APP_THEMES);
        break;
      case 'Refer a Friend':
        Get.lazyPut(() => ShareScreenController());
        Get.bottomSheet(
          ShareScreenView(),
          isScrollControlled: true,
          backgroundColor: Colors.transparent, // Makes the blur visible
          barrierColor: Colors.black.withOpacity(0.5), // Optional: slight dim background
        );
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
        Get.to(() =>
            Obx(() => InfoPage(
                title: "About Us",
                content: appDetails.aboutUs,
                loadingStatus: loadingStatus.value
            )));
        break;
      case 'Terms & Conditions':
        Get.to(() =>
            Obx(() => InfoPage(
                title: "Terms & Conditions",
                content: appDetails.termsAndConditions,
                loadingStatus: loadingStatus.value
            )));
        break;
      case 'Privacy Policy':
        Get.to(() =>
            Obx(() => InfoPage(
                title: "Privacy Policy",
                content: appDetails.aboutUs,
                loadingStatus: loadingStatus.value
            )));
        break;
      case 'Contact Admin':
        Get.toNamed(Routes.CONTACT_ADMIN);
        break;
      case 'FAQs':
        Get.toNamed(Routes.FAQ);
        break;
      case 'Logout':
        Get.dialog(
          CustomPopupDialog(
            title: 'Logout',
            description:
            'Are you sure you want to log out? You can\nlog back in anytime to continue using\nAffirmations.',
            primaryButtonText: 'Yes',
            secondaryButtonText: 'No',
            onPrimaryPressed: () {
              AppConstants.showLoader(context: Get.context!);
              logOut();
            },
            onSecondaryPressed: () => Get.back(),
          ),
          barrierDismissible: false,
        );
        break;
      case 'Delete':
        showDeleteAccountDialog();
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

  void logOut() async {
    try {
      var accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.logout,
        {},
        {
          'Authorization': accessToken,
        },
      );

      if (response.data["code"] == 100) {
        LocalStorage.clearData();

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.remove('lastTransactionDate');

        // FirebaseMessaging.instance.deleteToken().then(
        //       (value) => getAndSaveToken(),
        // );

        Future.delayed(
          const Duration(seconds: 2),
              () {
            AppConstants.showSnackbar(
              headText: "Success",
              content: "Logged Out successfully.",
              position: SnackPosition.BOTTOM,
            );
            Get.offNamedUntil(
              Routes.LOGIN,
                  (route) => false,
            );
          },
        );
      } else {
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

  // Add this method to check if user is premium
  bool get isPremiumUser {
    // Replace this with your actual premium check logic
    // For now, using GetStorage as you're already using it
    return box.read('is_premium') ?? false;
  }

  void showDeleteAccountDialog() {
    if (isPremiumUser) {
      // Premium user dialog (S2).....
      Get.dialog(
        CustomPopupDialog(
          title: 'Delete Your Account',
          description: 'Deleting your account permanently will erase all your data, and your lifetime access to premium features will be deactivated. This action cannot be undone. Are you sure you want to proceed?',
          primaryButtonText: 'Yes',
          secondaryButtonText: 'No',
          onPrimaryPressed: () {
            AppConstants.showLoader(context: Get.context!);
            deleteAccount();
          },
          onSecondaryPressed: () => Get.back(),
        ),
        barrierDismissible: false,
      );
    } else {
      // Free trial user dialog (S1)
      Get.dialog(
        CustomPopupDialog(
          title: 'Delete Your Account',
          description: 'Deleting your account is permanent and\ncannot be undone. Are you sure you want\nto proceed?',
          primaryButtonText: 'Yes',
          secondaryButtonText: 'No',
          onPrimaryPressed: () {
            AppConstants.showLoader(context: Get.context!);
            deleteAccount();
          },
          onSecondaryPressed: () => Get.back(),
        ),
        barrierDismissible: false,
      );
    }
  }

  void deleteAccount() async {
    try {
      var accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.deleteAccount,
        {},
        {
          'Authorization': accessToken,
        },
      );
      if (response.data["code"] == 100) {
        LocalStorage.clearData();

        // final prefs = await SharedPreferences.getInstance();
        // await prefs.remove('lastTransactionDate');

        // FirebaseMessaging.instance.deleteToken().then(
        //       (value) => getAndSaveToken(),
        // );

        Future.delayed(
          const Duration(seconds: 2),
              () {
            AppConstants.showSnackbar(
              headText: "Success",
              content: "Account deleted successfully.",
              position: SnackPosition.BOTTOM,
            );
            Get.offNamedUntil(
              Routes.LOGIN,
                  (route) => false,
            );
          },
        );
      } else {
        Get.back();
        Get.back();
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      Get.back();
      Get.back();
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    }
  }

}
