import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddEntryController extends GetxController {
  final shouldShowSheet = false.obs;
  final dismissedMorning = false.obs;
  final dismissedEvening = false.obs;
  final journalAddedMorning = false.obs;
  final journalAddedEvening = false.obs;
  final lastResetDate = DateTime.now().obs;

  @override
  void onInit() {
    super.onInit();
    _loadSettings();
  }

  void onAddEntry() {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    final key = "journalAdded_${DateFormat('yyyy-MM-dd').format(now)}_${isMorning ? 'morning' : 'evening'}";
    GetStorage().write(key, true);

    Get.back(); // Close sheet
    Get.toNamed(Routes.JOURNAL1); // Go to journal screen
  }

  void onDontAskMeAgain() {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    final key = "dontAskAgain_${isMorning ? 'morning' : 'evening'}";
    GetStorage().write(key, true);
    Get.back(); // Close sheet
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    dismissedMorning.value = prefs.getBool('dismissedMorning') ?? false;
    dismissedEvening.value = prefs.getBool('dismissedEvening') ?? false;
    journalAddedMorning.value = prefs.getBool('journalAddedMorning') ?? false;
    journalAddedEvening.value = prefs.getBool('journalAddedEvening') ?? false;
    lastResetDate.value = DateTime.parse(
        prefs.getString('lastResetDate') ?? DateTime.now().toString());

    _checkResetConditions();
  }

  Future<void> _saveSettings() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('dismissedMorning', dismissedMorning.value);
    await prefs.setBool('dismissedEvening', dismissedEvening.value);
    await prefs.setBool('journalAddedMorning', journalAddedMorning.value);
    await prefs.setBool('journalAddedEvening', journalAddedEvening.value);
    await prefs.setString('lastResetDate', lastResetDate.value.toString());
  }

  void _checkResetConditions() {
    final now = DateTime.now();
    if (now.day != lastResetDate.value.day ||
        now.month != lastResetDate.value.month ||
        now.year != lastResetDate.value.year) {
      resetDailyStates();
    }
  }

  Future<bool> checkShouldShowSheet() async {
    final now = DateTime.now();
    final hour = now.hour;
    final isMorning = hour < 12;

    _checkResetConditions();

    if (isMorning) {
      shouldShowSheet.value = !dismissedMorning.value && !journalAddedMorning.value;
    } else {
      shouldShowSheet.value = !dismissedEvening.value && !journalAddedEvening.value;
    }

    return shouldShowSheet.value;
  }

  Future<void> setJournalAdded() async {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      journalAddedMorning.value = true;
    } else {
      journalAddedEvening.value = true;
    }
    await _saveSettings();
  }

  Future<void> dismissForToday() async {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      dismissedMorning.value = true;
    } else {
      dismissedEvening.value = true;
    }
    shouldShowSheet.value = false;
    await _saveSettings();
  }

  Future<void> resetDailyStates() async {
    dismissedMorning.value = false;
    dismissedEvening.value = false;
    journalAddedMorning.value = false;
    journalAddedEvening.value = false;
    lastResetDate.value = DateTime.now();
    await _saveSettings();
  }

  Future<void> enableJournalReminder() async {
    await resetDailyStates();
  }
}