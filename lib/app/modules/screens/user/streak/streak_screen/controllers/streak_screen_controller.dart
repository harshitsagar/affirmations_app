// streak_screen_controller.dart - Updated version
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:table_calendar/table_calendar.dart';

class StreakScreenController extends GetxController {

  final inAppPurchase = InAppPurchase.instance.obs;

  final currentStreak = 0.obs;
  final currentStreakState = 'none'.obs ;
  final streakStatus = "Current Streak".obs;
  final freezeStreaksAvailable = 0.obs;
  final restoreStreaksAvailable = 0.obs;
  final selectedDate = DateTime.now().obs;
  final calendarFormat = CalendarFormat.month.obs;
  final focusedDay = DateTime.now().obs;
  final isPremiumUser = false.obs;

  // For monthly challenge progress
  final monthlyChallengeDays = 30.obs;
  final completedDays = 14.obs;

  // Calendar events
  final completedDates = <DateTime>[].obs;
  final freezedDates = <DateTime>[].obs;
  final restoredDates = <DateTime>[].obs;
  final brokenDates = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
    // Initialize with some mock data
    completedDates.addAll([
      DateTime(2025, 3, 1),
      DateTime(2025, 3, 2),
      DateTime(2025, 3, 3),
      DateTime(2025, 3, 4),
      DateTime(2025, 3, 5),
    ]);
  }

  void initializeUser() {
    // Check if user is premium and set initial values
    // This should come from your user authentication system
    isPremiumUser.value = false; // Change based on actual user status
    freezeStreaksAvailable.value = isPremiumUser.value ? 3 : 1;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    selectedDate.value = selectedDay;
    this.focusedDay.value = focusedDay;

    // Check if date is in future (only for freeze)
    if (selectedDay.isAfter(DateTime.now())) {
      if (freezeStreaksAvailable.value > 0) {
        showPurchaseStreakDialog('Freeze');
      }
    }
    // Check if date is in past and streak is broken (only for restore)
    else if (selectedDay.isBefore(DateTime.now()) &&
        !completedDates.contains(selectedDay)) {
      if (restoreStreaksAvailable.value > 0) {
        showRestoreStreakOption();
      } else {
        showPurchaseStreakDialog('Restore');
      }
    }
  }

  void showFreezeStreakOption() {
    Get.dialog(
      CustomPopupDialog(
        title: 'Use Freeze Streak',
        description: 'Are you sure you want to use freeze\nstreak to freeze it for one day?',
        primaryButtonText: 'Yes',
        secondaryButtonText: 'No',
        primaryButtonColor: Colors.black,
        onPrimaryPressed: () {
          Get.back();
          freezeStreak();
        },
        onSecondaryPressed: () => Get.back(),
      ),
      barrierDismissible: false,
    );
  }

  void showRestoreStreakOption() {
    Get.dialog(
      CustomPopupDialog(
        title: 'Use Restore Streak',
        description: 'Are you sure you want to use\nrestore streak?',
        primaryButtonText: 'Yes',
        secondaryButtonText: 'No',
        primaryButtonColor: Colors.black,
        onPrimaryPressed: () {
          Get.back();
          restoreStreak();
        },
        onSecondaryPressed: () => Get.back(),
      ),
      barrierDismissible: false,
    );
  }

  void showPurchaseStreakDialog(String type) {
    Get.dialog(
      CustomPopupDialog(
        title: 'Use $type Streak',
        description: 'Refer a friend to get 1 Streak $type for\nfree, or purchase one to stay on track.',
        primaryButtonText: 'Refer & Get Free',
        secondaryButtonText: 'Buy Streak Restore',
        onPrimaryPressed: () {
          Get.back();
          shareAppForFreeStreak(type);
        },
        onSecondaryPressed: () {
          Get.back();
          navigateToPurchaseScreen(type);
        },
        primaryButtonSize: 13.sp,
        secondaryButtonSize: 13.sp,
      ),
      barrierDismissible: false,
    );
  }

  void navigateToPurchaseScreen(String type) {



  }

  void shareAppForFreeStreak(String type) async {
    try {
      // await Share.share('Check out this awesome app!');
      // Reward user with free streak
      if (type == 'freeze') {
        freezeStreaksAvailable.value++;
      } else {
        restoreStreaksAvailable.value++;
      }
      Get.snackbar('Success', 'You earned 1 free $type streak!');
    } catch (e) {
      Get.snackbar('Error', 'Failed to share: $e');
    }
  }

  void freezeStreak() {
    if (freezeStreaksAvailable.value > 0) {
      freezeStreaksAvailable.value--;
      freezedDates.add(selectedDate.value);
      streakStatus.value = "Streak Freezed";
      currentStreakState.value = 'freeze'; // Add this line
      currentStreak.value++;
      completedDays.value++;
      update();
    }
  }

  void restoreStreak() {
    if (restoreStreaksAvailable.value > 0) {
      restoreStreaksAvailable.value--;
      restoredDates.add(selectedDate.value);
      streakStatus.value = "Streak Restored";
      currentStreakState.value = 'restore'; // Add this line
      currentStreak.value++;
      completedDays.value++;
      update();
    }
  }

  void breakStreak() {
    streakStatus.value = "Streak Broken";
    brokenDates.add(DateTime.now());
    currentStreak.value = 0;
    update();
  }

  // Check if user can view past months (premium only)
  bool canViewPastMonth(DateTime month) {
    if (isPremiumUser.value) return true;
    final now = DateTime.now();
    return month.year == now.year && month.month == now.month - 1;
  }


}