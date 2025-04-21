// addAffirmation_bottomsheet.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/add_affirmations_controller.dart';

class AddAffirmationBottomSheet extends GetView<AddAffirmationsController> {
  AddAffirmationBottomSheet({super.key});

  final TextEditingController _affirmationController = TextEditingController();
  final RxBool _isButtonEnabled = false.obs;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: BoxDecoration(
          color: const Color(0xFFFDF9F8),
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Drag handle
            Padding(
              padding: EdgeInsets.only(top: 14.h),
              child: Align(
                alignment: Alignment.center,
                child: Container(
                  height: 4.h,
                  width: 50.w,
                  decoration: BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
              ),
            ),

            // Title
            Padding(
              padding: EdgeInsets.only(top: 30.h, left: 20.w, right: 20.w),
              child: Text(
                'Add Affirmation',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
            ),

            // Description
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
              child: Text(
                'Write your own personalized affirmations.\nJust for you, visible only to you.',
                style: GoogleFonts.inter(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // Affirmation TextField
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFormField(
                onChanged: (text) {
                  if (text.length > controller.maxCharacters) {
                    _affirmationController.text = text.substring(0, controller.maxCharacters);
                    _affirmationController.selection = TextSelection.fromPosition(
                      TextPosition(offset: controller.maxCharacters),
                    );
                  } else {
                    controller.updateCharacterCount(text.length);
                    _isButtonEnabled.value = text.trim().isNotEmpty;
                  }
                },
                controller: _affirmationController,
                maxLines: 6,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                decoration: InputDecoration(
                  hintText: 'Affirmation',
                  hintStyle: GoogleFonts.inter(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFBDBDBD),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 12.h,
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide(color: const Color(0xFFE0E0E0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.r),
                    borderSide: BorderSide(color: const Color(0xFFBDBDBD)),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.only(right: 20.w, top: 10.h),
              child: Align(
                alignment: Alignment.centerRight,
                child: Obx(() => Text(
                  '(${controller.characterCount.value}/${controller.maxCharacters})',
                  style: GoogleFonts.inter(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFFA9A9A9),
                  ),
                )),
              ),
            ),

            // Save Button
            Padding(
              padding: EdgeInsets.only(top: 40.h, left: 24.w, right: 24.w),
              child: Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled.value ? () {
                    controller.addAffirmation(_affirmationController.text.trim());
                    _affirmationController.clear();
                    Get.back();
                  } : null,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isButtonEnabled.value
                        ? const Color(0xFF1E1E1E)
                        : const Color(0xFF757575),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                  ),
                  child: Text(
                    'Add',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}