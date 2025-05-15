import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/aboutProfileModel.dart';
import 'package:affirmations_app/app/data/models/user_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemindersController extends GetxController {

  // Loading state
  final loadingStatus = LoadingStatus.loading.obs;

  // Affirmations Reminder
  final affirmationCount = 10.obs;
  final affirmationStartTime = TimeOfDay(hour: 0, minute: 0).obs; // Default 12:00 AM
  final affirmationEndTime = TimeOfDay(hour: 0, minute: 0).obs;   // Default 12:00 AM

  // Journal Reminder
  final journalStartTime = TimeOfDay(hour: 10, minute: 30).obs;
  final journalEndTime = TimeOfDay(hour: 22, minute: 30).obs;
  final isJournalReminderActive = true.obs;

  final minAffirmations = 1;
  final maxAffirmations = 20;
  final minTimeSpan = 5; // in hours - same as affirmation_reminder_controller

  @override
  void onInit() {
    super.onInit();
    _loadUserReminderSettings();
  }

  Future<void> _loadUserReminderSettings() async {
    try {
      loadingStatus(LoadingStatus.loading);

      final userData = LocalStorage.getUserDetailsData();
      if (userData != null) {
        // Load affirmation settings - same format as affirmation_reminder_controller
        if (userData.affirmations != null) {
          affirmationCount.value = userData.affirmations!.countPerDay ?? 10;

          if (userData.affirmations!.startTime != null) {
            final startParts = userData.affirmations!.startTime!.split(':');
            affirmationStartTime.value = TimeOfDay(
              hour: int.parse(startParts[0]),
              minute: int.parse(startParts[1]),
            );
          } else {
            affirmationStartTime.value = TimeOfDay(hour: 0, minute: 0); // Default 12:00 AM
          }

          if (userData.affirmations!.endTime != null) {
            final endParts = userData.affirmations!.endTime!.split(':');
            affirmationEndTime.value = TimeOfDay(
              hour: int.parse(endParts[0]),
              minute: int.parse(endParts[1]),
            );
          } else {
            affirmationEndTime.value = TimeOfDay(hour: 0, minute: 0); // Default 12:00 AM
          }
        }

        // Load journal settings - same format as journal_controller
        if (userData.journalReminders != null) {
          if (userData.journalReminders!.startTime != null) {
            final startParts = userData.journalReminders!.startTime!.split(':');
            journalStartTime.value = TimeOfDay(
              hour: int.parse(startParts[0]),
              minute: int.parse(startParts[1]),
            );
          } else {
            journalStartTime.value = TimeOfDay(hour: 0, minute: 0); // Default 12:00 AM
          }

          if (userData.journalReminders!.endTime != null) {
            final endParts = userData.journalReminders!.endTime!.split(':');
            journalEndTime.value = TimeOfDay(
              hour: int.parse(endParts[0]),
              minute: int.parse(endParts[1]),
            );
          } else {
            journalEndTime.value = TimeOfDay(hour: 12, minute: 0); // Default 12:00 PM
          }
        }

        isJournalReminderActive.value = userData.reminderNotification ?? true;
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: 'Error',
        content: 'Failed to load reminder settings: ${e.toString()}',
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
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

  Future<void> selectAffirmationStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: affirmationStartTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null) affirmationStartTime.value = pickedTime;
  }

  Future<void> selectAffirmationEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: affirmationEndTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null) affirmationEndTime.value = pickedTime;
  }

  Future<void> selectJournalStartTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: journalStartTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null) journalStartTime.value = pickedTime;
  }

  Future<void> selectJournalEndTime(BuildContext context) async {
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: journalEndTime.value,
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child ?? Container(),
        );
      },
    );
    if (pickedTime != null) journalEndTime.value = pickedTime;
  }

  void toggleJournalReminder() {
    isJournalReminderActive.value = !isJournalReminderActive.value;
  }

  String _formatTimeOfDay(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }


  bool _isValidTimeRange(TimeOfDay start, TimeOfDay end) {
    final startHour = start.hour + start.minute / 60.0;
    final endHour = end.hour + end.minute / 60.0;
    return (endHour > startHour) && ((endHour - startHour) >= minTimeSpan);
  }

  Future<void> saveReminders() async {
    // Validate affirmation times - same as affirmation_reminder_controller
    if (affirmationStartTime.value.hour > affirmationEndTime.value.hour ||
        (affirmationStartTime.value.hour == affirmationEndTime.value.hour &&
            affirmationStartTime.value.minute > affirmationEndTime.value.minute)) {
      AppConstants.showSnackbar(
          headText: 'Invalid Time',
          content: 'End time cannot be earlier than Start time for Affirmations'
      );
      return;
    }

    if (!_isValidTimeRange(affirmationStartTime.value, affirmationEndTime.value)) {
      AppConstants.showSnackbar(
          headText: 'Invalid Time',
          content: 'Time span must be at least 5 hours for Affirmations'
      );
      return;
    }

    // Validate journal times - same as journal_controller
    final journalStartMinutes = journalStartTime.value.hour * 60 + journalStartTime.value.minute;
    final journalEndMinutes = journalEndTime.value.hour * 60 + journalEndTime.value.minute;

    if (journalStartMinutes == journalEndMinutes) {
      AppConstants.showSnackbar(
          headText: 'Invalid Times',
          content: 'Start and End times cannot be the same for Journal'
      );
      return;
    }

    if (journalStartTime.value.hour >= 12) {
      AppConstants.showSnackbar(
          headText: 'Invalid Start Time',
          content: 'Start time must be between 12:00 AM - 11:59 AM for Journal'
      );
      return;
    }

    if (journalEndTime.value.hour < 12) {
      AppConstants.showSnackbar(
          headText: 'Invalid End Time',
          content: 'End time must be between 12:00 PM - 11:59 PM for Journal'
      );
      return;
    }

    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "affirmationsCountPerDay": affirmationCount.value,
          "affirmationsStartTime": _formatTimeOfDay(affirmationStartTime.value),
          "affirmationsEndTime": _formatTimeOfDay(affirmationEndTime.value),
          "journalReminderStartTime": _formatTimeOfDay(journalStartTime.value),
          "journalReminderEndTime": _formatTimeOfDay(journalEndTime.value),
        },
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response["code"] == 100) {
        final updatedUser = User.fromJson(response["data"]);
        LocalStorage.setUserDetailsData(userDetailsData: updatedUser);

        AppConstants.showSnackbar(
          headText: 'Success',
          content: 'Reminder settings saved successfully',
        );

        // Force navigation back to settings screen
        Get.offNamedUntil(Routes.SETTINGS, (route) => route.settings.name == Routes.SETTINGS);

      } else {
        throw Exception(response["message"] ?? "Failed to save reminders");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: 'Error',
        content: 'Failed to save reminders: ${e.toString()}',
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

}