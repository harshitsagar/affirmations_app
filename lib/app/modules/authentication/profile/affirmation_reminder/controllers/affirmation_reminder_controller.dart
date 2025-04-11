import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
    final startHour = start.hour + start.minute / 60.0;
    final endHour = end.hour + end.minute / 60.0;

    // Ensure start time is always before end time and the gap is at least 5 hours
    return (endHour > startHour) && ((endHour - startHour) >= minTimeSpan);
  }

  void savePreferences() {

    if (startTime.value.hour > endTime.value.hour ||
        (startTime.value.hour == endTime.value.hour &&
            startTime.value.minute > endTime.value.minute)) {
      Get.snackbar(
        '❌ Invalid Time',
        'End time cannot be earlier than Start time',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(12.w),
        borderRadius: 12.r,
      );
      return;
    }

    if (!_isValidTimeRange(startTime.value, endTime.value)) {
      Get.snackbar(
        'Invalid Time',
        'Time span must be at least 5 hours',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.black87,
        colorText: Colors.white,
        duration: const Duration(seconds: 3),
        margin: EdgeInsets.all(12.w),
        borderRadius: 12.r,
        icon: const Icon(Icons.warning_amber_rounded, color: Colors.white),
        messageText: Text(
          'Time span must be at least 5 hours',
          style: TextStyle(
            fontSize: 14.sp, // Slightly larger font
            fontWeight: FontWeight.bold,
            color: Colors.white, // Darker shade of white
          ),
        ),
      );
      return;
    }

    // Navigate to the next screen here ......
    Get.dialog(
      CustomPopupDialog(
        title: 'Notifications Permission',
        description: 'Enable notifications to receive\ndaily affirmations.Without permission, you won’t get alerts to keep you motivated.',
        // No need to specify button texts as they're now the defaults
        onPrimaryPressed: () {
          // Handle "Ask Not to Track" action
          Get.back();
          Get.offAllNamed(Routes.AFFIRMATIONS);
        },
        onSecondaryPressed: () {
          // Handle "Allow" action
          Get.back();
          Get.offAllNamed(Routes.AFFIRMATIONS);
        },
        primaryButtonText: "Don't Allow" ,
        secondaryButtonText: 'Allow',
        descriptionWidth: 300.w,
      ),
      barrierDismissible: false,
    );

  }

}