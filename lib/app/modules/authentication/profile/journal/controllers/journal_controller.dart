import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JournalController extends GetxController {

  ///journal_view2 controller code here .....
  // Mood selection
  final selectedMood = RxString('');
  final moods = [
    'Feeling Amazing',
    'Doing Well',
    'Feeling Okay',
    'Not Great',
    'Having a Tough Time'
  ];

  // Notes field
  final notes = ''.obs;
  final maxNotesLength = 100;

  void selectMood(String mood) {
    selectedMood.value = mood;
  }

  void updateNotes(String text) {
    if (text.length <= maxNotesLength) {
      notes.value = text;
    }
  }

  bool get isMoodSelected => selectedMood.value.isNotEmpty;

  void navigateToNextScreen() {
    if (!isMoodSelected) {
      Get.snackbar(
        'Selection Required',
        'Please select how you feel',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      return;
    }
    Get.toNamed(Routes.JOURNAL_REMINDER);
  }


  /// journal_reminder controller code here .....
  final startTime = TimeOfDay(hour: 0, minute: 0).obs; // Default 12:00 AM
  final endTime = TimeOfDay(hour: 12, minute: 0).obs;  // Default 12:00 PM

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

  void navigateToHearAboutScreen() {
    // Convert TimeOfDay to minutes for easier comparison
    final startMinutes = startTime.value.hour * 60 + startTime.value.minute;
    final endMinutes = endTime.value.hour * 60 + endTime.value.minute;

    // Validation 1: Start and End times cannot be same
    if (startMinutes == endMinutes) {
      Get.snackbar(
        'Invalid Times',
        'Start and End times cannot be the same',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // Validation 2: Start time must be AM (00:00-11:59)
    if (startTime.value.hour >= 12) {
      Get.snackbar(
        'Invalid Start Time',
        'Start time must be between 12:00 AM - 11:59 AM',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // Validation 3: End time must be PM (12:00-23:59)
    if (endTime.value.hour < 12) {
      Get.snackbar(
        'Invalid End Time',
        'End time must be between 12:00 PM - 11:59 PM',
        snackPosition: SnackPosition.TOP,
        duration: const Duration(seconds: 2),
      );
      return;
    }

    // All validations passed - proceed to next screen
    Get.toNamed(Routes.HEAR_ABOUT);
  }


}
