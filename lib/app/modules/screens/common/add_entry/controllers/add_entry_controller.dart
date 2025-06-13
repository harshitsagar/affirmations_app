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

  // Key constants
  static String _getJournalAddedKey(String dateKey, bool isMorning) =>
      "journalAdded_${dateKey}_${isMorning ? 'morning' : 'evening'}";

  static String _getDontAskKey(bool isMorning) =>
      "dontAskAgain_${isMorning ? 'morning' : 'evening'}";

  static String _getJournalShownKey(String dateKey, bool isMorning) =>
      "journalShown_${dateKey}_${isMorning ? 'morning' : 'evening'}";

  @override
  void onInit() {
    super.onInit();
    _checkResetConditions();
  }

  void onAddEntry() {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    final dateKey = DateFormat('yyyy-MM-dd').format(now);
    final journalAddedKey = "journalAdded_${dateKey}_${isMorning ? 'morning' : 'evening'}";

    // Mark journal as added for this time period
    GetStorage().write(_getJournalAddedKey(dateKey, isMorning), true);
    Get.back();
    Get.toNamed(Routes.Journal_Home);
  }

  void onDontAskMeAgain() {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    final dontAskKey = "dontAskAgain_${isMorning ? 'morning' : 'evening'}";

    // Mark as "don't ask again" for this time period
    GetStorage().write(_getDontAskKey(isMorning), true);
    Get.back();
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
    final lastReset = GetStorage().read<String>('lastResetDate');

    if (lastReset == null ||
        now.day != DateTime.parse(lastReset).day ||
        now.month != DateTime.parse(lastReset).month ||
        now.year != DateTime.parse(lastReset).year) {
      resetDailyStates();
    }
  }

  Future<bool> checkShouldShowSheet() async {
    final now = DateTime.now();
    final isMorning = now.hour < 12;
    final dateKey = DateFormat('yyyy-MM-dd').format(now);

    // Check if we should show the sheet
    final hasAddedJournal = GetStorage().read(_getJournalAddedKey(dateKey, isMorning)) ?? false;
    final hasDontAsk = GetStorage().read(_getDontAskKey(isMorning)) ?? false;
    final hasShown = GetStorage().read(_getJournalShownKey(dateKey, isMorning)) ?? false;

    // Reset daily states if it's a new day
    _checkResetConditions();

    // Don't show if user has selected "Don't ask me again" or already added journal
    if (hasDontAsk || hasAddedJournal || hasShown) {
      return false;
    }

    // Mark as shown for this session
    GetStorage().write(_getJournalShownKey(dateKey, isMorning), true);
    return true;
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
    final now = DateTime.now();
    final dateKey = DateFormat('yyyy-MM-dd').format(now);

    // Clear all today's journal-related keys
    GetStorage().remove(_getJournalAddedKey(dateKey, true));
    GetStorage().remove(_getJournalAddedKey(dateKey, false));
    GetStorage().remove(_getJournalShownKey(dateKey, true));
    GetStorage().remove(_getJournalShownKey(dateKey, false));

    // Update last reset date
    GetStorage().write('lastResetDate', now.toString());
  }

  Future<void> enableJournalReminder() async {
    await resetDailyStates();
  }
}