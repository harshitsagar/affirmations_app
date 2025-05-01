import 'package:affirmations_app/app/data/api_provider.dart';
import 'package:affirmations_app/app/data/config.dart';
import 'package:affirmations_app/app/data/models/faq_model.dart';
import 'package:affirmations_app/app/helpers/constants/api_constants.dart';
import 'package:affirmations_app/app/helpers/constants/app_constants.dart';
import 'package:get/get.dart';

// class FaqItem {
//   final String question;
//   final String answer;
//
//   FaqItem({required this.question, required this.answer});
// }

class FaqController extends GetxController {

  final _faqList = Rx<List<FAQData>>([]);
  List<FAQData> get faqList => _faqList.value;

  final loadingStatus = LoadingStatus.loading.obs;

  final int itemsPerPage = 30;
  int currentPage = 1;
  var isLoading = false.obs;
  var hasMore = true.obs;
  // var displayedFaqs = <FaqItem>[].obs;
  var expandedIndex = Rx<int?>(null);

  //  dummy data......
  /*
  final List<FaqItem> _demoFaqs = [
    FaqItem(
      question: "Can to create custom affirmations?",
      answer: "Yes, you can create custom affirmations in the app by going to the 'Create Affirmation' section.",
    ),
    FaqItem(
      question: "How do to reset password?",
      answer: "You can reset your password by selecting 'Forgot Password' on the Sign-In screen. Enter your registered email, and we'll send you a link to create a new password.",
    ),
    FaqItem(
      question: "How do to affirmation reminders?",
      answer: "You can set affirmation reminders by going to the 'Reminders' section in Settings and selecting your preferred time and frequency.",
    ),
    FaqItem(
      question: "How do to change app theme?",
      answer: "You can change the app theme in the 'Settings' section. Choose between Light and Dark mode.",
    ),
    FaqItem(
      question: "How do to contact support?",
      answer: "You can contact support by going to the 'Help & Support' section in the app and selecting 'Contact Us'.",
    ),
    FaqItem(
      question: "How do to delete my account?",
      answer: "To delete your account, go to 'Settings', select 'Account', and choose 'Delete Account'. Please note that this action is irreversible.",
    ),
    FaqItem(
      question: "How do to share affirmations?",
      answer: "You can share affirmations by selecting the 'Share' option on the affirmation screen. Choose your preferred sharing method.",
    ),
    FaqItem(
      question: "How do to change language?",
      answer: "You can change the app language in the 'Settings' section under 'Language'. Select your preferred language from the list.",
    ),
    FaqItem(
      question: "How do to enable notifications?",
      answer: "You can enable notifications in the 'Settings' section under 'Notifications'. Toggle the switch to turn notifications on or off.",
    ),
    FaqItem(
      question: "How do to backup my data?",
      answer: "You can backup your data by going to the 'Settings' section and selecting 'Backup & Restore'. Choose your preferred backup method.",
    ),
    FaqItem(
      question: "How do to restore my data?",
      answer: "You can restore your data by going to the 'Settings' section and selecting 'Backup & Restore'. Choose the restore option and follow the prompts.",
    ),

  ];

   */

  @override
  void onInit() {
    super.onInit();
    fetchAllFAQs();
  }

  void fetchAllFAQs() async {
    try {
      loadingStatus(LoadingStatus.loading);
      final response = await APIProvider().postAPICall(
        ApiConstants.faqList,
        {},
        {},
      );

      if (response.data["code"] == 100) {
        var data = Data.fromJson(
          response.data["data"],
        );
        _faqList.value = data.list;
      } else {
        AppConstants.showSnackbar(
          headText: "Failed",
          content: response.data["message"],
          position: SnackPosition.BOTTOM,
        );
      }
    } catch (e) {
      AppConstants.showSnackbar(
        headText: "Failed",
        content: e.toString(),
        position: SnackPosition.BOTTOM,
      );
    } finally {
      loadingStatus(LoadingStatus.completed);
    }
  }

  /*
  Future<void> loadMoreFaqs() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;

    // Simulate API delay
    await Future.delayed(const Duration(milliseconds: 500));

    // Calculate items to show
    final startIndex = (currentPage - 1) * itemsPerPage;
    if (startIndex >= _demoFaqs.length) {
      hasMore.value = false;
      isLoading.value = false;
      return;
    }

    final endIndex = startIndex + itemsPerPage;
    final newFaqs = _demoFaqs.sublist(
      startIndex,
      endIndex > _demoFaqs.length ? _demoFaqs.length : endIndex,
    );

    displayedFaqs.addAll(newFaqs);
    currentPage++;
    hasMore.value = endIndex < _demoFaqs.length;

    isLoading.value = false;
  }

  void toggleExpansion(int index) {
    if (expandedIndex.value == index) {
      expandedIndex.value = null;
    } else {
      expandedIndex.value = index;
    }
  }

   */
}