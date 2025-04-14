import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreenController extends GetxController {

  final String shareMessage = 'Check out this amazing app! 🌟\nhttps://yourapp.link';
  final RxBool isCopied = false.obs;

  void shareToMessage() async {
    final uri = Uri(
      scheme: 'sms',
      queryParameters: {
        'body': shareMessage,
      },
    );
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // fallback
      // Share.share(shareMessage);
    }

    Clipboard.setData(ClipboardData(text: shareMessage));
  }

  void shareToWhatsapp() async {
    final uri = Uri.parse("https://wa.me/?text=${Uri.encodeComponent(shareMessage)}");

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      // fallback
      // Share.share(shareMessage);
    }

    Clipboard.setData(ClipboardData(text: shareMessage));
  }

  void copyMessageToClipboard() {

    Clipboard.setData(ClipboardData(text: shareMessage));
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

}
