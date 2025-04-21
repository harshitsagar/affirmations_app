import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/my_list_controller.dart';

class AddNewList extends GetView<MyListController> {

  final TextEditingController _listNameController = TextEditingController();
  final RxBool _isButtonEnabled = false.obs;

  AddNewList({super.key}) {
    _listNameController.addListener(() {
      _isButtonEnabled.value = _listNameController.text.trim().isNotEmpty;
    });
  }

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
            // Header with back button
            Padding(
              padding: EdgeInsets.only(top: 16.h, left: 16.w, right: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black,
                      size: 20.sp,
                    ),
                    onPressed: () => Get.back(),
                  ),
      
                  Text(
                    'Back',
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
      
            // title text ....
            Padding(
              padding: EdgeInsets.only(top: 20.h, left: 20.w, right: 20.w),
              child: Text(
                'Add New List',
                style: GoogleFonts.inter(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
      
            // Description text
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 20.w, right: 20.w),
              child: Text(
                'Create your personal list of affirmations. Just for you, visible only to you.',
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
                textAlign: TextAlign.start,
              ),
            ),
      
            SizedBox(height: 24.h),
      
            // List Title TextField
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: _buildTextField(_listNameController, 'List Title'),
            ),
      
           Spacer(),
      
            // Save Button
            Padding(
              padding: EdgeInsets.only(bottom: 30.h, left: 24.w, right: 24.w),
              child: Obx(() => SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _isButtonEnabled.value ? () {
                    controller.addNewList(_listNameController.text.trim());
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
                    'Save',
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

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      height: 50.h,
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
            color: const Color(0xFFBDBDBD), // soft gray
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: const Color(0xFFE0E0E0)), // light gray border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
            borderSide: BorderSide(color: const Color(0xFFBDBDBD)), // darker gray on focus
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

}