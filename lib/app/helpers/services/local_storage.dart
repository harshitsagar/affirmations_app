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

  static setAppSessionActive({
    required bool value,
  }) {
    prefs.write("appSessionActive", value);
  }

  static bool? isAppSessionActive() {
    return prefs.read("appSessionActive");
  }

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

  static clearData() {
    prefs.remove("userAccessToken");
    prefs.remove("ongoingCardioData");
    prefs.remove("sleepStartTime");
    prefs.remove("appSessionActive");
    prefs.erase();
  }
}
