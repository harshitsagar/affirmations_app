import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreenController extends GetxController {
  final RxBool isCopied = false.obs;
  final String defaultShareMessage = 'Check out this amazing app! 🌟\nhttps://yourapp.link';
  String currentContent = '';
  Function(bool)? onShared;

  void _handleShareSuccess() {
    if (onShared != null) {
      onShared!(true);
    }
    Get.back();
  }

  void initializeContent(String content, {Function(bool)? onSharedCallback}) {
    currentContent = content;
    onShared = onSharedCallback;
  }

  String get _shareMessage {
    return currentContent.isNotEmpty
        ? '$currentContent\n\n$defaultShareMessage'
        : defaultShareMessage;
  }

  void shareToMessage() async {
    final uri = Uri(
      scheme: 'sms',
      queryParameters: {'body': _shareMessage},
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      _handleShareSuccess();
    } else {
      _fallbackShare();
    }
    _copyToClipboard();
  }

  void shareToWhatsapp() async {
    final uri = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(_shareMessage)}");
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
      _handleShareSuccess();
    } else {
      _fallbackShare();
    }
    _copyToClipboard();
  }

  void copyMessageToClipboard() {
    _copyToClipboard();
    isCopied.value = true;

    Future.delayed(const Duration(seconds: 2), () {
      isCopied.value = false;
    });

    Get.snackbar(
      'Copied!',
      'Message copied to clipboard.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.black87,
      colorText: Colors.white,
      margin: const EdgeInsets.all(12),
      duration: const Duration(seconds: 2),
    );
  }

  void _copyToClipboard() {
    Clipboard.setData(ClipboardData(text: _shareMessage));
  }

  void _fallbackShare() {
    // Uncomment if you have the share package
    // Share.share(_shareMessage);
    copyMessageToClipboard();
  }
}