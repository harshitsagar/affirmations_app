import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'app_colors.dart';

mixin AppConstants {
  static void hideKeyboard() {
    FocusManager.instance.primaryFocus?.unfocus();
  }

  static showLoader({
    required BuildContext context,
    Color? color,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: Center(
            child: Container(
              height: 50.h,
              width: 260.w,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(
                  10.r,
                ),
              ),
              child: Platform.isAndroid
                  ? CircularProgressIndicator(
                strokeWidth: 2.w,
                color: color ?? AppColors.white, // Use passed color or default white
              )
                  : CupertinoActivityIndicator(
                color: color ?? AppColors.white, // Use passed color or default white
                animating: true,
                radius: 20.r,
              ),
            ),
          ),
        );
      },
    );
  }

  static showSnackbar({
    required String headText,
    required String content,
    SnackPosition? position,
    int duration = 2500,
  }) {
    Get.closeAllSnackbars();
    return Get.snackbar(
      headText,
      snackStyle: SnackStyle.FLOATING,
      content,
      duration: Duration(
        milliseconds: duration,
      ),
      snackPosition: position ?? SnackPosition.BOTTOM,
      backgroundColor: AppColors.black,
      colorText: AppColors.white,
    );
  }
}
