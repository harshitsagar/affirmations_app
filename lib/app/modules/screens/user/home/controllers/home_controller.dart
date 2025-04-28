import 'package:affirmations_app/app/modules/screens/common/add_entry/controllers/add_entry_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/add_entry/views/add_entry_view.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class HomeController extends GetxController {
  // Affirmation data
  final currentAffirmation = "".obs;
  final affirmationsList = <String>[].obs;
  final currentIndex = 0.obs;
  final favoriteAffirmations = <String>[].obs;

  // Progress tracking
  final currentAffirmationCount = 0.obs;
  final dailyGoal = 10.obs;
  final progressValue = 0.0.obs;
  final currentStreak = 0.obs;
  final streakProgress = 0.0.obs;

  // Audio state
  final isAudioPlaying = false.obs;
  final isAudioMuted = false.obs;

  final prefs = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initializeData();
    _showInitialJournalPopup();

    Get.lazyPut(() => AddEntryController());
    Get.lazyPut(() => ShareScreenController());
    Get.lazyPut(() => MyListController());
  }

  void _initializeData() {
    affirmationsList.value = [
      "I cultivate inner peace and soothing relationships this season.",
      "I am worthy of love and happiness.",
      "Every day I grow stronger and more confident.",
    ];

    if (affirmationsList.isNotEmpty) {
      currentAffirmation.value = affirmationsList.first;
    }

    _loadUserProgress();
  }

  void _loadUserProgress() {
    currentStreak.value = 0;
    streakProgress.value = 0.75;
    updateProgress();
  }

  void updateProgress() {
    progressValue.value = min(currentAffirmationCount.value / dailyGoal.value, 1.0);
    streakProgress.value = min(currentStreak.value / 7.0, 1.0);
  }

  void nextAffirmation() {
    if (currentAffirmationCount.value >= dailyGoal.value) {
      _handleGoalCompletion();
      return;
    }

    currentIndex.value = (currentIndex.value + 1) % affirmationsList.length;
    currentAffirmation.value = affirmationsList[currentIndex.value];
    currentAffirmationCount.value++;
    updateProgress();

    if (currentAffirmationCount.value == dailyGoal.value) {
      _handleGoalCompletion();
    }
  }

  void previousAffirmation() {
    if (currentIndex.value > 0) {
      currentIndex.value--;
    } else {
      currentIndex.value = affirmationsList.length - 1;
    }
    currentAffirmation.value = affirmationsList[currentIndex.value];
  }

  void _handleGoalCompletion() {
    currentStreak.value++;
    updateProgress();
    showGoalCompleteDialog();
    _showPostGoalJournalPopup();
  }

  void _showInitialJournalPopup() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (await Get.find<AddEntryController>().checkShouldShowSheet()) {
      _showJournalPopup();
    }
  }

  void _showPostGoalJournalPopup() async {
    await Future.delayed(const Duration(milliseconds: 500));
    if (await Get.find<AddEntryController>().checkShouldShowSheet()) {
      _showJournalPopup();
    }
  }

  void _showJournalPopup() {
    Get.bottomSheet(
      const AddEntryView(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
    );
  }

  // In HomeController class
  void toggleFavorite() {
    final current = currentAffirmation.value;
    if (favoriteAffirmations.contains(current)) {
      favoriteAffirmations.remove(current);
    } else {
      favoriteAffirmations.add(current);
    }

    // Update MyListController with the current favorites
    final myListController = Get.put(MyListController());
    myListController.favoriteAffirmations.assignAll(favoriteAffirmations);
    myListController.update(); // Force UI update

  }

  bool isCurrentFavorite() {
    return favoriteAffirmations.contains(currentAffirmation.value);
  }

  void toggleAudio() {
    if (isAudioMuted.value) {
      isAudioMuted.value = false;
      isAudioPlaying.value = true;
    } else if (isAudioPlaying.value) {
      isAudioPlaying.value = false;
      isAudioMuted.value = true;
    } else {
      isAudioPlaying.value = true;
      isAudioMuted.value = false;
    }
  }

  void showGoalCompleteDialog() {
    Get.dialog(
      AlertDialog(
        title: const Text("Daily Goal Reached!"),
        content: const Text("You've completed your affirmations for today."),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
              dailyGoal.value += 5;
              updateProgress();
            },
            child: const Text("Continue"),
          ),
          TextButton(
            onPressed: () => Get.back(),
            child: const Text("Done"),
          ),
        ],
      ),
    );
  }

  // Navigation methods
  void navigateToMyList() {
    Get.toNamed(Routes.MY_LIST);
  }

  void navigateToJournalHome() {
    Get.toNamed(Routes.Journal_Home);
  }

  void navigateToSettings() {
    Get.toNamed(Routes.SETTINGS);
  }

  void navigateToStreakScreen() {
    Get.toNamed(Routes.STREAK_SCREEN);
  }

  void showShareBottomSheet() {
    Get.bottomSheet(
      ShareScreenView(),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

}