import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/user_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AffirmationReminderController extends GetxController {

  final affirmationCount = 10.obs;
  final startTime = TimeOfDay(hour: 0, minute: 0).obs;
  final endTime = TimeOfDay(hour: 0, minute: 0).obs;
  final minAffirmations = 1;
  final maxAffirmations = 20;
  final minTimeSpan = 5; // in hours
  final loadingStatus = LoadingStatus.loading.obs;

  @override
  void onInit() {
    super.onInit();
    _loadExistingSettings();
  }

  void _loadExistingSettings() {
    final userData = LocalStorage.getUserDetailsData();
    if (userData?.affirmations != null) {
      affirmationCount.value = userData!.affirmations!.countPerDay ?? 10;

      // Parse start time
      if (userData.affirmations!.startTime != null) {
        final startParts = userData.affirmations!.startTime!.split(':');
        startTime.value = TimeOfDay(
          hour: int.parse(startParts[0]),
          minute: int.parse(startParts[1]),
        );
      }

      // Parse end time
      if (userData.affirmations!.endTime != null) {
        final endParts = userData.affirmations!.endTime!.split(':');
        endTime.value = TimeOfDay(
          hour: int.parse(endParts[0]),
          minute: int.parse(endParts[1]),
        );
      }
    }
  }

  void incrementAffirmations() {
    if (affirmationCount.value < maxAffirmations) {
      affirmationCount.value++;
    }
  }

  void decrementAffirmations() {
    if (affirmationCount.value > minAffirmations) {
      affirmationCount.value--;
    }
  }

  Future<void> selectStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: startTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );

    if (pickedTime != null) {
      startTime.value = pickedTime;
    }
  }

  Future<void> selectEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: endTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );

    if (pickedTime != null) {
      endTime.value = pickedTime;
    }
  }

  bool _isValidTimeRange(TimeOfDay start, TimeOfDay end) {
    final startHour = start.hour + start.minute / 60.0;
    final endHour = end.hour + end.minute / 60.0;

    // Ensure start time is always before end time and the gap is at least 5 hours
    return (endHour > startHour) && ((endHour - startHour) >= minTimeSpan);
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  Future<void> _updateAffirmationSettings() async {
    try {
      loadingStatus(LoadingStatus.loading);

      var accessToken = LocalStorage.getUserAccessToken();
      final userRef = LocalStorage.getUserDetailsData()?.id;
      if (userRef == null) throw Exception("User not logged in");

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "affirmationsCountPerDay": affirmationCount.value,
          "affirmationsStartTime": _formatTimeOfDay(startTime.value),
          "affirmationsEndTime": _formatTimeOfDay(endTime.value),
        },
        {
          'Authorization': accessToken.toString(),
        },
      );

      if (response["code"] == 100) {
        // Update local storage with new data
        // AboutProfileModel updatedUser = AboutProfileModel.fromJson(response);
        // var data = updatedUser.data;
        // LocalStorage.setUserDetailsData(
        //   userDetailsData: ;
        // );

        AppConstants.showSnackbar(
          headText: 'Success',
          content: 'Data saved successfully',
        );
      } else {
        throw Exception(response["message"]);
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: 'Error',
        content: e.toString(),
      );
      rethrow;
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  // Future<void> scheduleAffirmationNotifications() async {
  //   tz.initializeTimeZones();
  //
  //   final startHour = startTime.value.hour;
  //   final endHour = endTime.value.hour;
  //   final interval = (endHour - startHour) ~/ affirmationCount.value;
  //
  //   for (int i = 0; i < affirmationCount.value; i++) {
  //     final notificationTime = tz.TZDateTime.now(tz.local).add(
  //       Duration(hours: startHour + (interval * i), minutes: startTime.value.minute),
  //     );
  //
  //     // await flutterLocalNotificationsPlugin.zonedSchedule(
  //     //   i, // Unique ID for each notification
  //     //   'Affirmation Reminder',
  //     //   'Time for your affirmation!',
  //     //   notificationTime,
  //     //   const NotificationDetails(
  //     //     android: AndroidNotificationDetails(
  //     //       'affirmation_channel',
  //     //       'Affirmation Reminders',
  //     //       importance: Importance.high,
  //     //     ),
  //     //   ),
  //     //   androidAllowWhileIdle: true,
  //     //   uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
  //     // );
  //   }
  // }

  Future<bool> _updateNotificationPermission(bool enabled) async {
    try {

      loadingStatus(LoadingStatus.loading);

      final accessToken = LocalStorage.getUserAccessToken();
      final userRef = LocalStorage.getUserDetailsData()?.id;
      if (userRef == null) throw Exception("User not logged in");

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "reminderNotification": enabled,
        },
        {
          'Authorization': accessToken.toString(),
        },
      );

      if (response["code"] == 100) {
        // // Update local storage with new data
        // final updatedUser = User.fromJson(response.data["data"]);
        // LocalStorage.setUserDetailsData(userDetailsData: updatedUser);
        enabled == true ? AppConstants.showSnackbar(
          headText: 'Success',
          content: 'Enabled notifications to receive daily affirmations...',
        ) : AppConstants.showSnackbar(
          headText: 'Success',
          content: 'Disabled notifications to receive daily affirmations...',
        );
        return true;
      } else {
        throw Exception(response.data["message"]);
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: 'Error',
        content: e.toString(),
      );
      return false;
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  Future<void> savePreferences() async {
    if (startTime.value.hour > endTime.value.hour ||
        (startTime.value.hour == endTime.value.hour &&
            startTime.value.minute > endTime.value.minute)) {
      AppConstants.showSnackbar(
          headText: 'Invalid Time',
          content: 'End time cannot be earlier than Start time'
      );
      return;
    }

    if (!_isValidTimeRange(startTime.value, endTime.value)) {
      AppConstants.showSnackbar(
          headText: 'Invalid Time',
          content: 'Time span must be at least 5 hours'
      );
      return;
    }

    // First save the affirmation settings
    await _updateAffirmationSettings();

    // Then show the notification permission dialog
    Get.dialog(
      CustomPopupDialog(
        title: 'Notifications Permission',
        description: 'Enable notifications to receive\ndaily affirmations. Without permission, you won\'t get alerts to keep you motivated.',
        primaryButtonText: "Don't Allow",
        secondaryButtonText: 'Allow',
        descriptionWidth: 300.w,
        onPrimaryPressed: () async {
          Get.back();
          await _updateNotificationPermission(false);
          Get.offAllNamed(Routes.AFFIRMATIONS);
        },
        onSecondaryPressed: () async {
          Get.back();
          await _updateNotificationPermission(true);
          Get.offAllNamed(Routes.AFFIRMATIONS);
        },
      ),
      barrierDismissible: false,
    );
  }

}