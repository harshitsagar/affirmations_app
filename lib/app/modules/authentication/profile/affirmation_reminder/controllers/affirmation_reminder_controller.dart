import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AffirmationReminderController extends GetxController {
  final affirmationCount = 10.obs;
  final startTime = TimeOfDay(hour: 0, minute: 0).obs;
  final endTime = TimeOfDay(hour: 0, minute: 0).obs;
  final minAffirmations = 1;
  final maxAffirmations = 20;
  final minTimeSpan = 5; // in hours

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
    final startHour = start.hour + start.minute / 60;
    final endHour = end.hour + end.minute / 60;
    return (endHour - startHour) >= minTimeSpan;
  }

  void savePreferences() {
    if (!_isValidTimeRange(startTime.value, endTime.value)) {
      Get.snackbar('Invalid Time', 'Time span must be at least 5 hours');
      return;
    }
    Get.snackbar('Success', 'Reminder preferences saved');
    // Add your navigation or API call here
  }
}