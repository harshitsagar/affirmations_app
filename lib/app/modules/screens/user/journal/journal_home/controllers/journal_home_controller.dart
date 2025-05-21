import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/journalDetailsModel.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/modules/screens/user/journal/filter/controllers/filter_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/journal/filter/views/filter_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ChartData {
  final DateTime date;
  final String? morningMood;
  final String? nightMood;
  final String? morningNotes;
  final String? nightNotes;

  ChartData(this.date, this.morningMood, this.nightMood,
      {this.morningNotes, this.nightNotes});
}

class JournalHomeController extends GetxController {
  // Mood selection
  final selectedMood = Rx<String?>(null);
  final notesController = TextEditingController();
  final notesLength = 0.obs;
  final maxNotesLength = 100;

  // Chart data
  final chartData = <ChartData>[].obs;
  final dateRangeText = 'Select Date Range'.obs;

  // Journal entry details
  final selectedDateHasEntry = false.obs;
  final morningMood = Rx<String?>(null);
  final nightMood = Rx<String?>(null);
  final morningNotes = ''.obs;
  final nightNotes = ''.obs;

  final selectedDate = Rx<DateTime?>(null);
  final isEditingEntry = false.obs;
  final loadingStatus = LoadingStatus.loading.obs;
  final errorMessage = Rx<String?>(null);

  final moods = [
    'Feeling Amazing',
    'Doing Well',
    'Feeling Okay',
    'Not Great',
    'Having a Tough Time'
  ];

  @override
  void onInit() {
    super.onInit();
    _initializeController();
  }

  void _initializeController() {
    notesController.addListener(() {
      notesLength.value = notesController.text.length;
    });

    // Load initial data for default range (last 7 days)
    final now = DateTime.now();
    final weekAgo = now.subtract(const Duration(days: 6));
    generateChartDataForRange(weekAgo, now);
  }

  @override
  void onClose() {
    notesController.dispose();
    super.onClose();
  }

  Future<void> fetchJournalData(DateTime fromDate, DateTime toDate) async {
    try {
      loadingStatus(LoadingStatus.loading);
      errorMessage.value = null;

      final accessToken = LocalStorage.getUserAccessToken();
      final userRef = LocalStorage.getUserDetailsData()?.id;

      if (userRef == null || accessToken == null) {
        throw Exception("User not authenticated");
      }

      final response = await APIProvider().postAPICall(
        ApiConstants.journalDetails,
        {
          "userRef": userRef,
          "fromDate": DateFormat('yyyy-MM-dd').format(fromDate),
          "toDate": DateFormat('yyyy-MM-dd').format(toDate),
        },
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        final model = JournalDetailModel.fromJson(response.data);
        _processJournalData(model);
      } else {
        throw Exception(response.data["message"] ?? "Failed to fetch journal data");
      }
    } catch (e) {
      errorMessage.value = e.toString();
      AppConstants.showSnackbar(
        headText: "Error",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  void _processJournalData(JournalDetailModel model) {
    chartData.clear();

    // Process graph data from API
    for (var graphItem in model.data.graph) {
      chartData.add(ChartData(
        graphItem.date,
        graphItem.morning == "Not Recorded" ? null : graphItem.morning,
        graphItem.night == "Not Recorded" ? null : graphItem.night,
        morningNotes: graphItem.morningText.isNotEmpty ? graphItem.morningText : null,
        nightNotes: graphItem.nightText.isNotEmpty ? graphItem.nightText : null,
      ));
    }

    // Sort by date
    chartData.sort((a, b) => a.date.compareTo(b.date));

    // Update date range text
    if (chartData.isNotEmpty) {
      updateDateRangeText(chartData.first.date, chartData.last.date);
    }
  }

  void updateDateRangeText(DateTime fromDate, DateTime toDate) {
    if (fromDate.month != toDate.month) {
      dateRangeText.value =
      '${DateFormat('dd MMM').format(fromDate)} - ${DateFormat('dd MMM yyyy').format(toDate)}';
    } else {
      dateRangeText.value =
      '${DateFormat('dd').format(fromDate)} - ${DateFormat('dd MMM yyyy').format(toDate)}';
    }
  }

  num? moodToNumber(String? mood) {
    if (mood == null) return null;
    switch (mood) {
      case 'Having a Tough Time': return 1;
      case 'Not Great': return 2;
      case 'Feeling Okay': return 3;
      case 'Doing Well': return 4;
      case 'Feeling Amazing': return 5;
      default: return null;
    }
  }

  void loadEntryForDate(DateTime date) {
    selectedDate.value = date;
    isEditingEntry.value = false;

    final index = chartData.indexWhere((item) =>
    item.date.year == date.year &&
        item.date.month == date.month &&
        item.date.day == date.day);

    if (index != -1) {
      final data = chartData[index];
      morningMood.value = data.morningMood;
      nightMood.value = data.nightMood;
      morningNotes.value = data.morningNotes ?? '';
      nightNotes.value = data.nightNotes ?? '';
      selectedDateHasEntry.value = data.morningMood != null || data.nightMood != null;
    } else {
      resetEntryDetails();
    }
  }

  void resetEntryDetails() {
    morningMood.value = null;
    nightMood.value = null;
    morningNotes.value = '';
    nightNotes.value = '';
    selectedDateHasEntry.value = false;
  }

  void generateChartDataForRange(DateTime fromDate, DateTime toDate) {
    fetchJournalData(fromDate, toDate);
  }

  void selectMood(String mood) {
    selectedMood.value = mood;
  }

  void updateNotes(String value) {
    notesLength.value = value.length;
  }

  Future<void> submitJournalEntry() async {
    if (selectedDate.value == null || selectedMood.value == null) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Please select a mood",
        position: SnackPosition.BOTTOM,
      );
      return;
    }

    try {
      loadingStatus(LoadingStatus.loading);
      final accessToken = LocalStorage.getUserAccessToken();
      final userRef = LocalStorage.getUserDetailsData()?.id;

      if (userRef == null || accessToken == null) {
        throw Exception("User not authenticated");
      }

      final now = DateTime.now();
      final isMorning = now.hour < 12;
      final type = isMorning ? "MORNING" : "NIGHT";

      final response = await APIProvider().postAPICall(
        ApiConstants.addJournal,
        {
          "userRef": userRef,
          "mood": selectedMood.value,
          "text": notesController.text.isNotEmpty ? notesController.text : "",
          "type": type,
        },
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        // Refresh data after successful submission
        await fetchJournalData(
          selectedDate.value!.subtract(const Duration(days: 3)),
          selectedDate.value!.add(const Duration(days: 3)),
        );

        // Reset form
        selectedMood.value = null;
        notesController.clear();
        notesLength.value = 0;

        AppConstants.showSnackbar(
          headText: "Success",
          content: "Journal entry added successfully",
          position: SnackPosition.BOTTOM,
        );
      } else {
        throw Exception(response.data["message"] ?? "Failed to add journal entry");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  void openFilter() {
    Get.lazyPut(() => FilterController());
    Get.bottomSheet(
      FilterView(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.6),
    );
  }
}

/*import 'package:affirmations_app/app/modules/screens/user/journal/filter/controllers/filter_controller.dart';
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

 */