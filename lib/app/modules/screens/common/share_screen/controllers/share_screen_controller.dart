import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreenController extends GetxController {
  final RxBool isCopied = false.obs;
  final String defaultMessage = "Check out this affirmation app:";
  final String appLink = "https://yourappstorelink.com"; // Replace with your actual app link
  String currentContent = '';
  Function(bool)? onShared;
  bool shareOnlyAppLink = false;

  // void _handleShareSuccess() {
  //   if (onShared != null) {
  //     onShared!(true);
  //   }
  //   Get.back();
  // }

  void initializeContent(String content, {Function(bool)? onSharedCallback, bool onlyAppLink = false}) {
    currentContent = content;
    onShared = onSharedCallback;
    shareOnlyAppLink = onlyAppLink;
  }

  // String get shareMessage {
  //   return """Affirmation : ${currentContent.isNotEmpty ? currentContent : 'Check out this affirmation'}\n\nDownload the app for more affirmations:\n$appLink""";
  // }

  String get shareMessage {
    if (shareOnlyAppLink) {
      return "$defaultMessage\n$appLink";
    }
    return """${currentContent.isNotEmpty ? currentContent : 'Check out this affirmation'}\n\nDownload the app for more:\n$appLink""";
  }

  void shareToMessage() async {
    if (currentContent.isEmpty) {
      Get.snackbar("Error", "No affirmation text to share");
      return;
    }

    final uri = Uri(
      scheme: 'sms',
      queryParameters: {'body': shareMessage},
    );

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // Fallback to generic share
        await launchUrl(Uri.parse('sms:?body=${Uri.encodeComponent(currentContent)}'));
      }
    } catch (e) {
      Get.snackbar("Error", "Could not open messaging app");
      debugPrint("Message sharing error: $e");
    }
  }

  void shareToWhatsapp() async {
    if (currentContent.isEmpty) {
      Get.snackbar("Error", "No affirmation text to share");
      return;
    }

    final encodedText = Uri.encodeComponent(shareMessage);
    final uri = Uri.parse("whatsapp://send?text=$encodedText");

    try {
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri);
      } else {
        // Fallback to web WhatsApp
        await launchUrl(Uri.parse("https://wa.me/?text=$encodedText"));
      }
    } catch (e) {
      Get.snackbar("Error", "WhatsApp not installed");
      debugPrint("WhatsApp sharing error: $e");
    }
  }

  void copyMessageToClipboard() {
    if (currentContent.isEmpty) return;

    Clipboard.setData(ClipboardData(text: shareMessage));
    isCopied.value = true;
    Future.delayed(2.seconds, () => isCopied.value = false);

    Get.snackbar(
      "Copied!",
      "Affirmation copied to clipboard",
      snackPosition: SnackPosition.BOTTOM,
    );
    // _handleShareSuccess();
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: shareMessage));
  }

  void _fallbackShare() {
    // Uncomment if you have the share package
    // Share.share(_shareMessage);
    copyMessageToClipboard();
  }
}