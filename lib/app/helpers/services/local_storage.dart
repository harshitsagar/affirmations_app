import 'package:get_storage/get_storage.dart';

import '../../data/models/user_model.dart';

class LocalStorage {
  static final prefs = GetStorage();

  static setUserAccessToken({
    required String? userAccessToken,
  }) {
    prefs.write("userAccessToken", userAccessToken);
  }

  static String? getUserAccessToken() {
    return prefs.read("userAccessToken");
  }

  // Onboarding status
  static setOnboardingCompleted({bool value = true}) {
    prefs.write("onboarding_completed", value);
  }

  static bool getOnboardingCompleted() {
    return prefs.read("onboarding_completed") ?? false;
  }

  // Profile completion status
  static setProfileCompleted({bool value = true}) {
    prefs.write("profile_completed", value);
  }

  static bool getProfileCompleted() {
    return prefs.read("profile_completed") ?? false;
  }

  // App session active status
  static setAppSessionActive({
    required bool value,
  }) {
    prefs.write("appSessionActive", value);
  }

  static bool? isAppSessionActive() {
    return prefs.read("appSessionActive");
  }

  // FCM Token
  static setFCMToken(String value) {
    prefs.write("USER_FCM_TOKEN", value);
  }

  static String getFCMToken() {
    return prefs.read("USER_FCM_TOKEN") ?? "";
  }

  // user details
  static setUserDetailsData({
    required User? userDetailsData,
  }) {
    prefs.write("userDetailsData", userDetailsData?.toJson());
  }

  static User? getUserDetailsData() {
    final data = prefs.read("userDetailsData");
    return data != null ? User.fromJson(data) : null;
  }

  // exercise
  static setOngoingCardioData({
    required Map<String, dynamic>? value,
  }) {
    prefs.write("ongoingCardioData", value);
  }

  static Map<String, dynamic>? getOngoingCardioData() {
    return prefs.read("ongoingCardioData");
  }

  // sleep
  static setSleepStartTime({
    required String? sleepStartTime,
  }) {
    prefs.write("sleepStartTime", sleepStartTime);
  }

  static String? getSleepStartTime() {
    return prefs.read("sleepStartTime");
  }


  // Clear all data (logout)
  static clearData() {

    prefs.erase(); // Clear everything

  }

}
