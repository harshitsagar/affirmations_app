import 'package:affirmations_app/app/modules/screens/user/journal/filter/controllers/filter_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/journal/filter/views/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChartData {

  final DateTime date;
  final String? morningMood;
  final String? nightMood;

  ChartData(this.date, this.morningMood, this.nightMood);
}

class JournalHomeController extends GetxController {

  // Mood selection
  final selectedMood = Rx<String?>(null);
  final notesController = TextEditingController();
  final notesLength = 0.obs;
  final maxNotesLength = 100;

  // Chart data
  final chartData = <ChartData>[].obs;
  final dateRangeText = '12-18 Dec 2024'.obs;

  // Journal entry details
  final selectedDateHasEntry = false.obs;
  final morningMood = Rx<String?>(null);
  final nightMood = Rx<String?>(null);
  final morningNotes = ''.obs;
  final nightNotes = ''.obs;

  final selectedDate = Rx<DateTime?>(null);
  final isEditingEntry = false.obs;
  final selectedIndex = Rx<int?>(null);  // Add this

  final moods = [
    'Feeling Amazing',
    'Doing Well',
    'Feeling Okay',
    'Not Great',
    'Having a Tough Time'
  ];

  // In your JournalHomeController
  num? moodToNumber(String? mood) {
    if (mood == null) return null;
    switch (mood) {
      case 'Having a Tough Time':
      case 'Tough Time':
        return 1;
      case 'Not Great':
        return 2;
      case 'Feeling Okay':
      case 'Okay':
        return 3;
      case 'Doing Well':
        return 4;
      case 'Feeling Amazing':
      case 'Amazing':
        return 5;
      default:
        return null;
    }
  }

  // Add this method to load entry for a specific date
  void loadEntryForDate(DateTime date) {
    selectedDate.value = date;
    isEditingEntry.value = false;

    final index = chartData.indexWhere((item) =>
    item.date.year == date.year &&
        item.date.month == date.month &&
        item.date.day == date.day);

    selectedIndex.value = index;

    if (index != -1) {
      final data = chartData[index];

      morningMood.value = data.morningMood;
      nightMood.value = data.nightMood;

      selectedDateHasEntry.value = (data.morningMood != null && data.morningMood!.isNotEmpty) ||
          (data.nightMood != null && data.nightMood!.isNotEmpty);
    } else {
      // If no entry exists
      morningMood.value = null;
      nightMood.value = null;
      selectedDateHasEntry.value = false;
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    // Initialize with sample data
    _initializeChartData();

    notesController.addListener(() {
      notesLength.value = notesController.text.length;
    });
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  void _initializeChartData() {
    final now = DateTime.now();
    for (int i = 6; i >= 0; i--) {
      final date = now.subtract(Duration(days: i));
      chartData.add(ChartData(
        date,
        null,  // ✅ no morning mood
        null,  // ✅ no night mood
      ));
    }
  }

  // In JournalHomeController.dart
  void generateChartDataForRange(DateTime fromDate, DateTime toDate) {
    chartData.clear();

    // Generate dates for the range
    final days = toDate.difference(fromDate).inDays;

    for (int i = 0; i <= days; i++) {
      final currentDate = fromDate.add(Duration(days: i));

      // Here you would fetch actual data for each date from your database
      // For now, we'll add sample data
      chartData.add(ChartData(
        currentDate,
        i % 2 == 0 ? 'Doing Well' : 'Feeling Okay', // Sample morning mood
        i % 3 == 0 ? 'Not Great' : null, // Sample night mood
      ));
    }
  }

  void selectMood(String mood) {
    selectedMood.value = mood;
  }

  void updateNotes(String value) {
    notesLength.value = value.length;
  }

  void submitJournalEntry() {
    if (selectedDate.value == null) return;

    final now = DateTime.now();
    final isMorning = now.hour < 12;  // ✅ consider before 5PM as morning

    final date = selectedDate.value!;
    final index = chartData.indexWhere((item) =>
    item.date.year == date.year &&
        item.date.month == date.month &&
        item.date.day == date.day);

    if (index != -1) {
      final existing = chartData[index];
      chartData[index] = ChartData(
        date,
        isMorning ? selectedMood.value : existing.morningMood,
        isMorning ? existing.nightMood : selectedMood.value,
      );
    }

    // Update local mood state
    if (isMorning) {
      morningMood.value = selectedMood.value;
      morningNotes.value = notesController.text;
    } else {
      nightMood.value = selectedMood.value;
      nightNotes.value = notesController.text;
    }

    selectedMood.value = null;
    notesController.clear();
    notesLength.value = 0;
    selectedDateHasEntry.value = true;
    isEditingEntry.value = false;
  }


  // // Update your submit method
  // void submitJournalEntry() {
  //   if (selectedDate.value == null) return;
  //
  //   final isMorning = DateTime.now().hour < 12;
  //   if (isMorning) {
  //     morningMood.value = selectedMood.value;
  //     morningNotes.value = notesController.text;
  //   } else {
  //     nightMood.value = selectedMood.value;
  //     nightNotes.value = notesController.text;
  //   }
  //
  //   // Update chart data
  //   final date = selectedDate.value!;
  //   final index = chartData.indexWhere((item) =>
  //   item.date.year == date.year &&
  //       item.date.month == date.month &&
  //       item.date.day == date.day);
  //
  //   if (index != -1) {
  //     if (isMorning) {
  //       chartData[index] = ChartData(
  //         date,
  //         selectedMood.value,
  //         chartData[index].nightMood,
  //       );
  //     } else {
  //       chartData[index] = ChartData(
  //         date,
  //         chartData[index].morningMood,
  //         selectedMood.value,
  //       );
  //     }
  //   }
  //
  //   // Reset fields
  //   selectedMood.value = null;
  //   notesController.clear();
  //   notesLength.value = 0;
  //   selectedDateHasEntry.value = true;
  //   isEditingEntry.value = false;
  // }

  void openFilter() {
    // In your main.dart or routes file
    Get.lazyPut(() => FilterController());
    Get.bottomSheet(
      FilterView(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
    );
  }
}