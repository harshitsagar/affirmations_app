import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../helpers/services/local_storage.dart';

class JournalController extends GetxController {

  ///journal_view2 controller code here .....
  // Mood selection
  final selectedMoodIndex = RxInt(-1); // -1 means no selection
  final loadingStatus = LoadingStatus.loading.obs;
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
  late TextEditingController notesController;

  @override
  void onInit() {
    super.onInit();
    notesController = TextEditingController(text: notes.value);
    // Listen for changes and update notes observable
    notesController.addListener(() {
      updateNotes(notesController.text);
    });
  }

  void selectMood(int index) {
    selectedMoodIndex.value = index;
    print(selectedMoodIndex.value);
  }

  void updateNotes(String text) {
    if (text.length <= maxNotesLength) {
      notes.value = text;
    }
  }

  bool get isMoodSelected => selectedMoodIndex.value != -1;

  // Convert UI index (0-4) to backend question ID (1-5)
  int get _selectedQuestionId => selectedMoodIndex.value + 1;

  Future<void> saveJournalEntry() async {
    if (!isMoodSelected) {
      AppConstants.showSnackbar(
        headText: 'Selection Required',
        content: 'Please select how you feel',
        position: SnackPosition.TOP,
      );
      return;
    }

    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "journalQuestion" : _selectedQuestionId, // Converted to backend ID (1-5)
          "journalAnswer": notes.value.isEmpty ? "" : notes.value,
        },
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response["code"] == 100) {
        Get.toNamed(Routes.JOURNAL_REMINDER);
      } else {
        throw Exception(response["message"] ?? "Failed to save journal entry");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to save journal entry: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
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

  Future<void> navigateToHearAboutScreen() async {
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

    // All validations passed - save the reminder times
    await saveJournalReminder();
  }

  Future<void> saveJournalReminder() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();

      final startTimeFormatted = _formatTimeOfDay(startTime.value);
      final endTimeFormatted = _formatTimeOfDay(endTime.value);

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.editProfile,
        {
          "journalReminderStartTime": startTimeFormatted,
          "journalReminderEndTime": endTimeFormatted,
        },
        {
          'Authorization': accessToken ?? "",
        },
      );

      if (response["code"] == 100) {
        Get.toNamed(Routes.HEAR_ABOUT);
      } else {
        throw Exception(response["message"] ?? "Failed to save journal reminder");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to save reminder: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  String _formatTimeOfDay(TimeOfDay time) {
    // Convert to 24-hour format HH:mm
    final hour = time.hour.toString().padLeft(2, '0');
    final minute = time.minute.toString().padLeft(2, '0');
    return '$hour:$minute';
  }

  @override
  void onClose() {
    notesController.dispose(); // Important to prevent memory leaks
    super.onClose();
  }

}
