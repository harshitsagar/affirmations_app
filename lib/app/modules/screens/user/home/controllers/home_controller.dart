import 'package:flutter/material.dart';
import 'package:get/get.dart';
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

  @override
  void onInit() {
    super.onInit();
    _initializeData();
  }

  void _initializeData() async {
    // Load affirmations
    affirmationsList.value = [
      "I cultivate inner peace and soothing relationships this season.",
      "I am worthy of love and happiness.",
      "Every day I grow stronger and more confident.",
      // Add more affirmations as needed
    ];

    if (affirmationsList.isNotEmpty) {
      currentAffirmation.value = affirmationsList.first;
    }

    // Initialize progress
    _loadUserProgress();
  }

  void _loadUserProgress() {
    // TODO: Load from shared preferences
    currentStreak.value = 0; // Example data
    streakProgress.value = 0.75; // Example 75% progress
    updateProgress();
  }

  void updateProgress() {
    progressValue.value = min(currentAffirmationCount.value / dailyGoal.value, 1.0);
    streakProgress.value = min(currentStreak.value / 7.0, 1.0); // Cap at 100%
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
  }

  void toggleFavorite() {
    final current = currentAffirmation.value;
    if (favoriteAffirmations.contains(current)) {
      favoriteAffirmations.remove(current);
    } else {
      favoriteAffirmations.add(current);
    }
  }

  bool isCurrentFavorite() {
    return favoriteAffirmations.contains(currentAffirmation.value);
  }

  void toggleAudio() {
    if (isAudioMuted.value) {
      // Unmute
      isAudioMuted.value = false;
      isAudioPlaying.value = true;
      // TODO: Resume audio playback
    } else if (isAudioPlaying.value) {
      // Mute
      isAudioPlaying.value = false;
      isAudioMuted.value = true;
      // TODO: Pause audio playback
    } else {
      // Start playing
      isAudioPlaying.value = true;
      isAudioMuted.value = false;
      // TODO: Start audio playback
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
              dailyGoal.value += 5; // Allow more affirmations
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
}