import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/models/favList_model.dart';
import 'package:affirmations_app/app/data/models/homeScreenModel.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:affirmations_app/app/helpers/services/local_storage.dart';
import 'package:affirmations_app/app/modules/screens/common/add_entry/controllers/add_entry_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/add_entry/views/add_entry_view.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/views/share_screen_view.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/favorites/controllers/favorites_controller.dart';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class HomeController extends GetxController {

  // Affirmation data
  final currentAffirmation = Rx<Affirmation?>(null);
  final affirmationsList = <Affirmation>[].obs;
  final currentIndex = 0.obs;
  final favoriteAffirmations = <String>[].obs;
  final isLoading = false.obs;

  // Progress tracking
  final currentAffirmationCount = 0.obs;
  final dailyGoal = 10.obs;
  final progressValue = 0.0.obs;
  final currentStreak = 0.obs;
  final streakProgress = 0.0.obs;

  // Audio state
  final FlutterTts flutterTts = FlutterTts();
  final isAudioPlaying = false.obs;
  final isAudioMuted = true.obs;

  final likedAffirmationIds = <String>[].obs;

  // Add these new fields
  final targetCount = 0.obs;
  final streakCount = 0.obs;
  final journalPending = false.obs;

  final prefs = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initTts();
    fetchAffirmations();
    _showInitialJournalPopup();

    Get.lazyPut(() => AddEntryController());
    Get.lazyPut(() => ShareScreenController());
    Get.lazyPut(() => MyListController());
  }

  // Update fetchAffirmations
  Future<void> fetchAffirmations() async {
    try {
      isLoading(true);
      final accessToken = LocalStorage.getUserAccessToken();

      final response = await APIProvider().postAPICall(
        ApiConstants.home,
        {},
        {'Authorization': accessToken ?? ""},
      );

      if (response.data["code"] == 100) {
        final model = HomeScreenModel.fromJson(response.data);


        // Update affirmations list
        affirmationsList.assignAll(model.data.affirmations);

        if (affirmationsList.isNotEmpty) {
          currentIndex.value = 0;
          currentAffirmation.value = affirmationsList.first;
        }
        await _fetchLikedAffirmations();
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
      _loadUserProgress();
    }
  }

  Future<void> _fetchLikedAffirmations() async {
    try {
      final accessToken = LocalStorage.getUserAccessToken();
      final response = await APIProvider().postAPICall(
        ApiConstants.favList,
        {},
        {'Authorization': accessToken ?? ""},
      );

      if (response.data["code"] == 100) {
        final model = FavoriteListModel.fromJson(response.data);
        likedAffirmationIds.assignAll(
            model.data?.where((item) => item.isLiked == true).map((item) =>
            item.sId ?? "").toList() ?? []
        );
      }
    } catch (e) {
      // Optional: Handle error
    }
  }

  // Add this new method to handle page changes
  void handlePageChange(int newIndex) {
    if (isAudioPlaying.value) {
      flutterTts.stop();
      isAudioPlaying.value = false;
    }

    if (newIndex > currentIndex.value) {
      currentAffirmationCount.value =
          min(currentAffirmationCount.value + 1, dailyGoal.value);
      updateProgress();

      if (currentAffirmationCount.value == dailyGoal.value) {
        _handleGoalCompletion();
      }
    }

    currentIndex.value = newIndex;
    currentAffirmation.value = affirmationsList[newIndex];
  }

  void _loadUserProgress() {
    currentStreak.value = 0;
    streakProgress.value = 0.75;
    updateProgress();
  }

  void updateProgress() {
    progressValue.value =
        min(currentAffirmationCount.value / dailyGoal.value, 1.0);
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
  /*
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

   */

  Future<void> toggleFavorite() async {
    try {
      if (currentAffirmation.value == null) return;
      final currentId = currentAffirmation.value!.id;
      if (currentId == null) return;

      final isCurrentlyLiked = likedAffirmationIds.contains(currentId);

      // Optimistic update - immediately change UI state
      if (isCurrentlyLiked) {
        likedAffirmationIds.remove(currentId);
        favoriteAffirmations.remove(currentAffirmation.value!.text);
      } else {
        likedAffirmationIds.add(currentId);
        favoriteAffirmations.add(currentAffirmation.value!.text ?? "");
      }
      update();

      final accessToken = LocalStorage.getUserAccessToken();
      final response = await APIProvider().postAPICall(
        ApiConstants.likeAffirmation,
        {
          "affirmationRef": currentId,
          "isLiked": !isCurrentlyLiked,
        },
        {
          'Authorization': accessToken ?? "",
          'Content-Type': 'application/json',
        },
      );

      if (response.data["code"] != 100) {
        // Revert if API fails
        if (isCurrentlyLiked) {
          likedAffirmationIds.add(currentId);
          favoriteAffirmations.add(currentAffirmation.value!.text ?? "");
        } else {
          likedAffirmationIds.remove(currentId);
          favoriteAffirmations.remove(currentAffirmation.value!.text);
        }
        update();
        throw Exception(response.data["message"] ?? "Failed to update favorite status");
      }

      // Update MyListController
      if (Get.isRegistered<MyListController>()) {
        final myListController = Get.find<MyListController>();
        myListController.favoriteAffirmations.assignAll(favoriteAffirmations);
        myListController.update();
      }

      // Refresh favorites list
      if (Get.isRegistered<FavoritesController>()) {
        await Get.find<FavoritesController>().fetchFavList();
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to update favorite: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  bool isCurrentFavorite() {
    if (currentAffirmation.value == null) return false;
    return likedAffirmationIds.contains(currentAffirmation.value!.id);
  }

  // audio flow .....
  Future<void> _initTts() async {
    try {
      // 1. First initialize the TTS engine
      await flutterTts.awaitSpeakCompletion(true);

      // 2. Set basic parameters
      await flutterTts.setLanguage("en-US");
      await flutterTts.setSpeechRate(0.4); // changed from 0.5 to 0.3
      await flutterTts.setVolume(1.0);
      await flutterTts.setPitch(1.0);

      // 3. Add the handlers - THIS IS WHERE YOU ADD THEM
      flutterTts.setStartHandler(() {
        isAudioPlaying.value = true;
      });

      flutterTts.setCompletionHandler(() {
        isAudioPlaying.value = false;
        isAudioMuted.value = true;
      });

      flutterTts.setCancelHandler(() {
        isAudioPlaying.value = false;
        isAudioMuted.value = true;
      });

      flutterTts.setErrorHandler((msg) {
        isAudioPlaying.value = false;
        isAudioMuted.value = true;
        AppConstants.showSnackbar(
          headText: "Error",
          content: "Text-to-speech error: $msg",
          position: SnackPosition.BOTTOM,
        );
      });
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to initialize TTS: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> toggleAudio() async {
    try {
      if (isAudioMuted.value) {
        // Unmute and start playing
        isAudioMuted.value = false;
        await _speakCurrentAffirmation();
      } else if (isAudioPlaying.value) {
        // Stop if currently playing
        await flutterTts.stop();
        isAudioPlaying.value = false;
        isAudioMuted.value = true;
      } else {
        // Start playing if not playing but unmuted
        await _speakCurrentAffirmation();
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to control audio: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
    }
  }

  Future<void> _speakCurrentAffirmation() async {
    if (currentAffirmation.value?.text?.isEmpty ?? true) return;
    isAudioPlaying.value = true;
    await flutterTts.speak(currentAffirmation.value!.text!);
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