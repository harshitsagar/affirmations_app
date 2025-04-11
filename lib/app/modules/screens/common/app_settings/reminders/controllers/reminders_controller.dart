import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RemindersController extends GetxController {
  // Affirmations Reminder
  final affirmationCount = 10.obs;
  final affirmationStartTime = TimeOfDay(hour: 10, minute: 0).obs;
  final affirmationEndTime = TimeOfDay(hour: 22, minute: 0).obs;

  // Journal Reminder
  final journalStartTime = TimeOfDay(hour: 10, minute: 30).obs;
  final journalEndTime = TimeOfDay(hour: 22, minute: 30).obs;
  final isJournalReminderActive = true.obs;

  final minAffirmations = 1;
  final maxAffirmations = 20;

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

  void saveReminders() {
    // Validate affirmation times
    if (affirmationStartTime.value.hour > affirmationEndTime.value.hour ||
        (affirmationStartTime.value.hour == affirmationEndTime.value.hour &&
            affirmationStartTime.value.minute > affirmationEndTime.value.minute)) {
      Get.snackbar(
        '❌ Invalid Time',
        'End time cannot be earlier than Start time for Affirmations',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
      return;
    }

    // Validate journal times
    if (journalStartTime.value.hour > journalEndTime.value.hour ||
        (journalStartTime.value.hour == journalEndTime.value.hour &&
            journalStartTime.value.minute > journalEndTime.value.minute)) {
      Get.snackbar(
        '❌ Invalid Time',
        'End time cannot be earlier than Start time for Journal',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
      );
      return;
    }

    // Save logic would go here
    Get.back(); // Return to settings screen
  }
}