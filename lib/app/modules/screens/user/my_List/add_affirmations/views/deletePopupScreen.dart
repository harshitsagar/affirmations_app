import 'dart:ui';
import 'package:affirmations_app/app/modules/screens/user/my_List/myList/controllers/my_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/add_affirmations_controller.dart';
import '../../../../../../widgets/customPopUp.dart';

class DeletePopupScreen extends StatelessWidget {
  const DeletePopupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          // Full screen blur background
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Get.back(),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                child: Container(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
            ),
          ),

          // Buttons at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.9,
              height: MediaQuery.of(context).size.height * 0.21,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Delete List Button (using GestureDetector)
                  GestureDetector(
                    onTap: () {
                      Get.dialog(
                        CustomPopupDialog(
                          title: 'Delete List',
                          description: 'Are you sure you want to delete this list?',
                          primaryButtonText: 'Yes',
                          secondaryButtonText: 'No',
                          onPrimaryPressed: () {
                            Get.back(); // Close confirmation dialog
                            Get.find<MyListController>().deleteList(
                                Get.find<AddAffirmationsController>().listName.value
                            );
                            Get.back(); // Close popup
                            Get.back(); // Go back to list view
                          },
                          onSecondaryPressed: () {
                            Get.back();
                            Get.back();
                          }, // Close confirmation dialog
                          descriptionWidth: 300.w,
                        ),
                        barrierDismissible: false
                        ,
                      );
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF9F8),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'Delete List',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 14.h),

                  // Cancel Button (using GestureDetector)
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFDF9F8),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: GoogleFonts.inter(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}