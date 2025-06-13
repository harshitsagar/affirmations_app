import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/models/editHomeModel.dart';
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
import 'package:affirmations_app/app/widgets/customPopUp.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:math';

import 'package:intl/intl.dart';

class HomeController extends GetxController {

  // for guest user ....
  final isGuestUser = false.obs;
  final guestAffirmations = <Affirmation>[].obs;

  // Affirmation data
  final currentAffirmation = Rx<Affirmation?>(null);
  final affirmationsList = <Affirmation>[].obs;
  final currentIndex = 0.obs;
  final favoriteAffirmations = <String>[].obs;
  final isLoading = false.obs;

  // Add these new fields
  final maxDailyAffirmations = 10.obs;
  final currentPage = 1.obs;
  final canLoadMore = true.obs;
  final isExploring = false.obs;
  final isGoalCompleted = false.obs;

  // Progress tracking
  final currentAffirmationCount = 1.obs;
  final dailyGoal = 0.obs;
  final progressValue = 0.0.obs;
  final currentStreak = 0.obs;
  final streakProgress = 0.0.obs;

  // Audio state
  final FlutterTts flutterTts = FlutterTts();
  final isAudioPlaying = false.obs;
  final isAudioMuted = true.obs;

  final likedAffirmationIds = <String>[].obs;

  final prefs = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _initTts();
    _checkGuestStatus();
    _showInitialJournalPopup();

    Get.lazyPut(() => AddEntryController());
    Get.lazyPut(() => ShareScreenController());
    Get.lazyPut(() => MyListController());
  }

  Future<void> _checkGuestStatus() async {
    final accessToken = LocalStorage.getUserAccessToken();
    if (accessToken == null || accessToken.isEmpty) {
      isGuestUser.value = true;
      dailyGoal.value = 10;
      await fetchGuestAffirmations();
    } else {
      isGuestUser.value = false;
      fetchAffirmations();
    }
  }

  Future<void> fetchGuestAffirmations() async {
    try {
      isLoading(true);
      final response = await APIProvider().postAPICall(
        ApiConstants.guestUser,
        {}, // Empty body for guest user
        {}, // No headers needed for guest
      );

      if (response.data["code"] == 100) {
        final affirmations = (response.data["data"] as List)
            .map((item) => Affirmation.fromJson(item))
            .toList();
        guestAffirmations.assignAll(affirmations);

        if (guestAffirmations.isNotEmpty) {
          currentAffirmation.value = guestAffirmations.first;
        }
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Update fetchAffirmations
  Future<void> fetchAffirmations({bool loadMore = false}) async {
    try {
      if (loadMore && !canLoadMore.value) return;

      isLoading(true);
      final accessToken = LocalStorage.getUserAccessToken();

      // Reset goal completion state when loading new affirmations (not loadMore)
      if (!loadMore) {
        isGoalCompleted.value = false;
        currentAffirmationCount.value = 1;
      }

      final response = await APIProvider().postAPICall(
        ApiConstants.home,
        {
          "page": loadMore ? currentPage.value + 1 : 1,
          "limit": 10,
        },
        {'Authorization': accessToken ?? ""},
      );

      if (response.data["code"] == 100) {
        final model = HomeScreenModel.fromJson(response.data);
        dailyGoal.value = model.data.target ?? 10;

        if (loadMore) {
          affirmationsList.addAll(model.data.affirmations);
          currentPage.value++;
        } else {
          affirmationsList.assignAll(model.data.affirmations);
          currentPage.value = 1;
        }

        canLoadMore.value = model.data.affirmations.isNotEmpty;

        if (affirmationsList.isNotEmpty) {
          currentIndex.value = 0;
          currentAffirmation.value = affirmationsList.first;
        }

        // Only update streak if the value makes sense (not 0 when we expect increment)
        if (!loadMore && (model.data.streakCount ?? 0) > 0) {
          currentStreak.value = model.data.streakCount!;
          streakProgress.value = min(currentStreak.value / 7.0, 1.0);
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

  // Add this new method to handle marking affirmations as seen
  Future<void> _markAffirmationAsSeen() async {
    try {
      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null || isGuestUser.value) return;

      final currentAffirmationId = currentAffirmation.value?.id;
      if (currentAffirmationId == null) return;

      final categoryRef = currentAffirmation.value?.categoryRef;
      if (categoryRef == null || categoryRef.isEmpty) return;

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.markAsRead,
        {
          "affirmationRef": currentAffirmationId,
          "categoryRef": categoryRef,
        },
        {'Authorization': accessToken},
      );

      print("*****MarkAsSeen : ${response.toString()}");

      if (response["code"] == 100) {
        final model = EditHomeModel.fromJson(response);
        // Update streak if needed
        if (model.data.streakCount != null && model.data.streakCount! > currentStreak.value) {
          currentStreak.value = model.data.streakCount!;
          streakProgress.value = min(currentStreak.value / 7.0, 1.0);
        }
      } else if (response["code"] == 500) {

        // If the affirmation is already marked as seen, we can silently fail or show a message
        print("******Affirmation already marked as seen");
        // AppConstants.showSnackbar(
        //     headText: "",
        //     content: "Affirmation already marked as seen",
        // );
      }
    } catch (e) {
      print('Error marking affirmation as seen: $e');
      // Silently fail - we don't want to disrupt the user experience
    }
  }

  Future<void> _markGoalAsRead() async {
    try {
      final accessToken = LocalStorage.getUserAccessToken();
      if (accessToken == null) return;

      final currentAffirmationId = currentAffirmation.value?.id;
      final categoryRef = currentAffirmation.value?.categoryRef;

      if (currentAffirmationId == null) return;

      final response = await APIProvider().formDataPostAPICall(
        ApiConstants.markAsRead,
        {
          "affirmationRef": currentAffirmationId,
          "categoryRef": categoryRef
        },
        {'Authorization': accessToken},
      );

      // print('******markAsRead response: ${response.toString()}');

      if (response["code"] == 100) {
        print('********Current streak before markAsRead: ${currentStreak.value}');
        final model = EditHomeModel.fromJson(response);
        print('*******Received streakCount from markAsRead: ${model.data.streakCount}');
        // Only update streak if the new value is greater than current
        if (model.data.streakCount != null && model.data.streakCount! > currentStreak.value) {
          currentStreak.value = model.data.streakCount!;
          streakProgress.value = min(currentStreak.value / 7.0, 1.0);
        }
        // Else keep the current streak value
      } else {
        throw Exception(response["message"] ?? "Failed to mark goal as read");
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Error",
        content: "Failed to update streak: ${e.toString()}",
        position: SnackPosition.BOTTOM,
      );
      isGoalCompleted.value = false;
    }
  }

  // Add this new method to handle page changes
  void handlePageChange(int newIndex) {

    if (isGuestUser.value && newIndex >= 1) {
      showGuestPopup();
      return;
    }

    if (isAudioPlaying.value) {
      flutterTts.stop();
      isAudioPlaying.value = false;
    }

    // Load more affirmations when reaching near the end
    if (newIndex >= affirmationsList.length - 1 && canLoadMore.value) {
      fetchAffirmations(loadMore: true);
    }

    // Update progress only if goal isn't completed
    if (newIndex > currentIndex.value && !isGoalCompleted.value) {
      currentAffirmationCount.value = min(currentAffirmationCount.value + 1, dailyGoal.value);
      updateProgress();

      // Mark the affirmation as seen when swiping to a new one
      _markAffirmationAsSeen();

      if (currentAffirmationCount.value >= dailyGoal.value) {
        _handleGoalCompletion();
      }
    }

    currentIndex.value = newIndex;
    currentAffirmation.value = isGuestUser.value
        ? guestAffirmations[0] // Always show first affirmation for guest
        : affirmationsList[newIndex];
  }

  void showGuestPopup() {
    Get.dialog(
      CustomPopupDialog(
        title: 'Please Login or Signup',
        description:
        "You're currently browsing as a guest. Please login to access this feature.",
        primaryButtonText: 'Login',
        secondaryButtonText: 'Signup',
        onPrimaryPressed: () {
          Get.offAllNamed(Routes.LOGIN);
        },
        onSecondaryPressed: () {
          Get.offAllNamed(Routes.SIGNUP);
        },
      ),
      barrierDismissible: false,
    );
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

  // Update the _handleGoalCompletion method
  void _handleGoalCompletion() async {
    if (!isExploring.value &&
        currentAffirmationCount.value >= dailyGoal.value &&
        !isGoalCompleted.value) {
      isGoalCompleted.value = true;
      // currentStreak.value++;
      // streakProgress.value = min(currentStreak.value / 7.0, 1.0);
      await _markGoalAsRead();
      showGoalCompleteDialog();
    }
  }


  void _showInitialJournalPopup() async {

    // Don't show for guest users
    if (isGuestUser.value) return;

    await Future.delayed(const Duration(milliseconds: 500));
    if (await Get.find<AddEntryController>().checkShouldShowSheet()) {
      _showJournalPopup();
    }
  }

  void _showPostGoalJournalPopup() async {
    await Future.delayed(const Duration(milliseconds: 500));
    final addEntryController = Get.find<AddEntryController>();

    // Only show if conditions are met and we haven't shown it already for this goal completion
    if (await addEntryController.checkShouldShowSheet()) {
      _showJournalPopup();
      // Mark as shown for this session
      final now = DateTime.now();
      final isMorning = now.hour < 12;
      final key = "journalShown_${DateFormat('yyyy-MM-dd').format(now)}_${isMorning ? 'morning' : 'evening'}";
      GetStorage().write(key, true);
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

  Future<void> toggleFavorite() async {

    if (isGuestUser.value) {
      showGuestPopup();
      return;
    }

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

    // Check if user is guest
    if (isGuestUser.value) {
      showGuestPopup();
      return;
    }

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

    // Check if user is guest
    if (isGuestUser.value) {
      showGuestPopup();
      return;
    }

    if (currentAffirmation.value?.text.isEmpty ?? true) return;
    isAudioPlaying.value = true;
    await flutterTts.speak(currentAffirmation.value!.text);
  }

  void showGoalCompleteDialog() {
    Get.dialog(
      CustomPopupDialog(
        title: 'Goal Completed!',
        description: 'You have met your daily affirmation goal! Want to explore more? You can increase your goal to keep going, and it will be updated for your daily streak too.',
        primaryButtonText: 'Explore More',
        singleButtonMode: true,
        descriptionWidth: 250.w,
        onPrimaryPressed: () {
          Get.back();
          // Set exploring mode to true
          isExploring.value = true;
          // Load more affirmations
          fetchAffirmations(loadMore: true);
        },
      ),
      barrierDismissible: false,
    );
  }

  // Navigation methods
  void navigateToMyList() {

    if (isGuestUser.value) {
      Get.toNamed(Routes.MY_LIST);
      return;
    }

    Get.toNamed(Routes.MY_LIST);
  }

  void navigateToJournalHome() {

    if (isGuestUser.value) {
      Get.toNamed(Routes.Journal_Home);
      return;
    }

    Get.toNamed(Routes.Journal_Home);
  }

  void navigateToSettings() {

    if (isGuestUser.value) {
      showGuestPopup();
      return;
    }

    Get.toNamed(Routes.SETTINGS);
  }

  void navigateToStreakScreen() {

    if (isGuestUser.value) {
      Get.toNamed(Routes.STREAK_SCREEN);
      return;
    }

    Get.toNamed(Routes.STREAK_SCREEN);
  }

  void showShareBottomSheet() {
    if (isGuestUser.value) {
      showGuestPopup();
      return;
    }

    if (currentAffirmation.value == null || currentAffirmation.value!.text == null) {
      Get.snackbar("Error", "No affirmation to share");
      return;
    }

    final affirmationText = currentAffirmation.value!.text!;

    Get.bottomSheet(
      ShareScreenView(affirmation: affirmationText),
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black.withOpacity(0.5),
    );
  }

}