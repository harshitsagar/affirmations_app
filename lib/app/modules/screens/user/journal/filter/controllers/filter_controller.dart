import 'package:affirmations_app/app/modules/screens/user/journal/journal_home/controllers/journal_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterController extends GetxController {
  final fromDate = Rx<DateTime?>(null);
  final toDate = Rx<DateTime?>(null);
  final errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize with default dates (last 7 days)
    final now = DateTime.now();
    toDate.value = now;
    fromDate.value = now.subtract(const Duration(days: 6));
  }

  Future<void> selectFromDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: fromDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      fromDate.value = selected;
      _validateDates();
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: toDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      toDate.value = selected;
      _validateDates();
    }
  }

  void _validateDates() {
    if (fromDate.value != null && toDate.value != null) {
      if (fromDate.value!.isAfter(toDate.value!)) {
        errorMessage.value = 'From date cannot be after To date';
      } else if (toDate.value!.difference(fromDate.value!).inDays > 30) {
        errorMessage.value = 'Maximum range of 30 days is allowed';
      } else {
        errorMessage.value = null;
      }
    }
  }

  void applyFilters() {
    _validateDates();

    if (errorMessage.value != null) {
      Get.snackbar('Error', errorMessage.value!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    if (fromDate.value != null && toDate.value != null) {
      final journalController = Get.find<JournalHomeController>();
      journalController.generateChartDataForRange(fromDate.value!, toDate.value!);
    }

    Get.back();
  }
}

/*import 'package:affirmations_app/app/modules/screens/user/journal/journal_home/controllers/journal_home_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class FilterController extends GetxController {
  final fromDate = Rx<DateTime?>(null);
  final toDate = Rx<DateTime?>(null);
  final errorMessage = Rx<String?>(null);

  @override
  void onInit() {
    super.onInit();
    // Initialize with default dates (last 7 days)
    // final now = DateTime.now();
    // toDate.value = now;
    // fromDate.value = now.subtract(const Duration(days: 6));
  }

  Future<void> selectFromDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: fromDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      fromDate.value = selected;
      _validateDates();
    }
  }

  Future<void> selectToDate(BuildContext context) async {
    final selected = await showDatePicker(
      context: context,
      initialDate: toDate.value ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );

    if (selected != null) {
      toDate.value = selected;
      _validateDates();
    }
  }

  void _validateDates() {
    if (fromDate.value != null && toDate.value != null) {
      if (fromDate.value!.isAfter(toDate.value!)) {
        errorMessage.value = 'From date cannot be after To date';
      } else if (toDate.value!.difference(fromDate.value!).inDays < 1) {
        errorMessage.value = 'Minimum range of 2 days is required';
      } else if (toDate.value!.difference(fromDate.value!).inDays > 6) {
        errorMessage.value = 'Maximum range of 7 days is allowed';
      } else {
        errorMessage.value = null;
      }
    }
  }

  void applyFilters() {
    _validateDates();

    if (errorMessage.value != null) {
      Get.snackbar('Error', errorMessage.value!,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white);
      return;
    }

    // Format the date range text
    if (fromDate.value != null && toDate.value != null) {
      final journalController = Get.find<JournalHomeController>();

      // Update the date range text
      if (fromDate.value!.month != toDate.value!.month) {
        journalController.dateRangeText.value =
        '${DateFormat('dd MMM').format(fromDate.value!)} - ${DateFormat('dd MMM yyyy').format(toDate.value!)}';
      } else {
        journalController.dateRangeText.value =
        '${DateFormat('dd').format(fromDate.value!)} - ${DateFormat('dd MMM yyyy').format(toDate.value!)}';
      }

      // Generate chart data for the selected range
      journalController.generateChartDataForRange(fromDate.value!, toDate.value!);
    }

    Get.back();
  }
}

 */