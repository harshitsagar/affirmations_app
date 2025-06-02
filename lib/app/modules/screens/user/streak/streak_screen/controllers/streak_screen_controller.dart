// streak_screen_controller.dart - Updated version
import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/models/freezeStreakModel.dart';
import 'package:affirmations_app/app/data/models/monthlyCalenderModel.dart';
import 'package:affirmations_app/app/data/models/restoreStreakModel.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:affirmations_app/app/modules/screens/user/home/controllers/home_controller.dart';
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:intl/intl.dart';
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
  final isLoading = false.obs;

  // For monthly challenge progress
  final monthlyChallengeDays = 30.obs;
  final completedDays = 0.obs;

  // Calendar events
  final completedDates = <DateTime>[].obs;
  final freezedDates = <DateTime>[].obs;
  final restoredDates = <DateTime>[].obs;
  final brokenDates = <DateTime>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeUser();
    fetchMonthlyStreakDetails();
  }

  Future<void> fetchMonthlyStreakDetails() async {
    try {
      isLoading(true);
      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null) return;

      final response = await APIProvider().postAPICall(
        ApiConstants.monthlyStreakDetails,
        {
          "calendarDate": DateFormat('yyyy-MM-dd').format(focusedDay.value),
        },
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        final monthlyData = MontlyCalenderModel.fromJson(response.data);
        _processMonthlyStreakData(monthlyData.data ?? []);
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to load streak data: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Add this helper method to your controller
  bool isSameDate(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }

  void _processMonthlyStreakData(List<MontlyCalenderModelData> data) {
    completedDates.clear();
    freezedDates.clear();
    restoredDates.clear();
    brokenDates.clear();

    int completedCount = 0;

    for (var dayData in data) {
      final date = DateTime.parse(dayData.date!);

      if (dayData.goalCompleted == true) {
        completedDates.add(date);
        completedCount++;
      }
      if (dayData.streakFreeze == true) {
        freezedDates.add(date);
        completedCount++;
      }
      if (dayData.streakRestore == true) {
        restoredDates.add(date);
        completedCount++;
      }
      if (dayData.streakBroken == true) {
        brokenDates.add(date);
      }
    }

    completedDays.value = completedCount;
    currentStreak.value = _calculateCurrentStreak();
    update();
  }

  int _calculateCurrentStreak() {
    // Sort dates in descending order
    final allDates = [...completedDates, ...freezedDates, ...restoredDates];
    allDates.sort((a, b) => b.compareTo(a));

    int streak = 0;
    DateTime currentDate = DateTime.now();

    for (var date in allDates) {
      if (isSameDay(date, currentDate)) {
        streak++;
        currentDate = currentDate.subtract(const Duration(days: 1));
      } else if (date.isBefore(currentDate)) {
        // If there's a gap, break the streak
        break;
      }
    }

    return streak;
  }

  Future<void> freezeStreak() async {
    try {
      if (freezeStreaksAvailable.value <= 0) return;

      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null) return;

      final response = await APIProvider().postAPICall(
        ApiConstants.freezeStreak,
        {
          "calendarDate": DateFormat('yyyy-MM-dd').format(selectedDate.value),
        },
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        final freezeData = FreezeStreakModel.fromJson(response.data);

        freezeStreaksAvailable.value--;
        freezedDates.add(selectedDate.value);
        streakStatus.value = "Streak Freezed";
        currentStreakState.value = 'freeze';
        currentStreak.value = freezeData.data?.streakCount ?? currentStreak.value + 1;
        completedDays.value++;

        // Update UI
        update();
        Get.snackbar('Success', freezeData.message ?? 'Streak frozen successfully');
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to freeze streak: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> restoreStreak() async {
    try {
      if (restoreStreaksAvailable.value <= 0) return;

      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null) return;

      final response = await APIProvider().postAPICall(
        ApiConstants.restoreStreak,
        {
          "calendarDate": DateFormat('yyyy-MM-dd').format(selectedDate.value),
        },
        {'Authorization': accessToken},
      );

      if (response.data["code"] == 100) {
        final restoreData = RestoreStreakModel.fromJson(response.data);

        restoreStreaksAvailable.value--;
        restoredDates.add(selectedDate.value);
        streakStatus.value = "Streak Restored";
        currentStreakState.value = 'restore';
        currentStreak.value = restoreData.data?.streakCount ?? currentStreak.value + 1;
        completedDays.value++;

        // Update UI
        update();
        Get.snackbar('Success', restoreData.message ?? 'Streak restored successfully');
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to restore streak: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  void initializeUser() {
    final user = LocalStorage.getUserDetailsData();
    // Check subscription status to determine if user is premium
    isPremiumUser.value = user?.subscriptionStatus == 'active'; // Adjust based on your actual subscription field
    freezeStreaksAvailable.value = isPremiumUser.value ? 3 : 1;
    restoreStreaksAvailable.value = isPremiumUser.value ? 3 : 1;
  }

  void onDaySelected(DateTime selectedDay, DateTime focusedDay) {

    if (Get.find<HomeController>().isGuestUser.value) {
      Get.find<HomeController>().showGuestPopup();
      return;
    }

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

    if (Get.find<HomeController>().isGuestUser.value) {
      Get.find<HomeController>().showGuestPopup();
      return;
    }

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

    if (Get.find<HomeController>().isGuestUser.value) {
      Get.find<HomeController>().showGuestPopup();
      return;
    }

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
    Get.toNamed('/purchase-screen', arguments: {'type': type})?.then((result) {
      if (result != null) {
        // Update the available streaks based on purchase
        // Explicitly cast the values to int using .toInt()
        freezeStreaksAvailable.value += (result['freezeCount'] as num).toInt();
        restoreStreaksAvailable.value += (result['restoreCount'] as num).toInt();
      }
    });
  }

  void shareAppForFreeStreak(String type) async {
    try {
      isLoading(true);
      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null) {
        Get.snackbar('Error', 'Please login to use this feature');
        return;
      }

      // Show the share bottom sheet
      Get.bottomSheet(
        ShareScreenView(
          onShared: (success) async {
            if (success) {
              // Call API to reward user after successful share
              final response = await APIProvider().formDataPostAPICall(
                ApiConstants.buyRestore,
                {
                  "free": true, // Mark as free reward
                  "productId": type == 'freeze' ? 'freeze_streak' : 'restore_streak',
                },
                {'Authorization': accessToken},
              );

              // if (response["code"] == 100) {
              //   // Reward user with free streak
              //   if (type == 'freeze') {
              //     freezeStreaksAvailable.value++;
              //   } else {
              //     restoreStreaksAvailable.value++;
              //   }
              //   Get.snackbar('Success', 'You earned 1 free $type streak!');
              // } else {
              //   Get.snackbar('Error', response.data["message"] ?? 'Failed to process referral');
              // }
            }
          },
        ),
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        barrierColor: Colors.black.withOpacity(0.5),
      );
    } catch (e) {
      Get.snackbar('Error', 'Failed to process referral: ${e.toString()}');
    } finally {
      isLoading(false);
    }
  }

  // void freezeStreak() {
  //   if (freezeStreaksAvailable.value > 0) {
  //     freezeStreaksAvailable.value--;
  //     freezedDates.add(selectedDate.value);
  //     streakStatus.value = "Streak Freezed";
  //     currentStreakState.value = 'freeze'; // Add this line
  //     currentStreak.value++;
  //     completedDays.value++;
  //     update();
  //   }
  // }

  // void restoreStreak() {
  //   if (restoreStreaksAvailable.value > 0) {
  //     restoreStreaksAvailable.value--;
  //     restoredDates.add(selectedDate.value);
  //     streakStatus.value = "Streak Restored";
  //     currentStreakState.value = 'restore'; // Add this line
  //     currentStreak.value++;
  //     completedDays.value++;
  //     update();
  //   }
  // }

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