import 'package:affirmations_app/app/helpers/services/themeServices.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../data/components/images_path.dart';
import '../controllers/journal_controller.dart';

class JournalView2 extends GetView<JournalController> {
  const JournalView2({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(JournalController());

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(bgImage),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        decoration: ThemeService.getBackgroundDecoration(),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  title: "",
                  onBackPressed: () => Get.back(),
                ),

                SizedBox(height: 20.h),

                // Question 1
                Text(
                  'How do you feel right now?',
                  style: GoogleFonts.inter(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 20.h),

                // Mood options list - removed Expanded since we're using SingleChildScrollView
                SizedBox(
                  height: 280.h,
                  child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(), // Disable scrolling since we have outer scroll
                    itemCount: controller.moods.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final mood = controller.moods[index];
                      return Obx(() {
                        final isSelected = controller.selectedMoodIndex.value == index;
                        return _buildMoodOption(mood, isSelected, () => controller.selectMood(index));
                      });
                    },
                  ),
                ),

                SizedBox(height: 20.h),

                // Title with character counter in same row
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Why do you feel this way?',
                      style: GoogleFonts.inter(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '(${controller.notes.value.length}/${controller.maxNotesLength})',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                )),

                SizedBox(height: 16.h),

                // TextField
                TextField(
                  controller: controller.notesController, // Add controller to sync with notes
                  maxLines: 4,
                  maxLength: controller.maxNotesLength,
                  decoration: InputDecoration(
                    hintText: 'Add notes here...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffA9A9A9),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.r),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: EdgeInsets.all(16.r),
                    counterText: '', // hides default counter
                  ),
                ),

                SizedBox(height: 20.h),

                // Next Button
                Padding(
                  padding: EdgeInsets.only(bottom: 10.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveJournalEntry,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.inter(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Replace the existing _buildMoodOption with:
  Widget _buildMoodOption(String mood, bool isSelected, VoidCallback onTap) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 42.h,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30.r),
          ),
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mood,
                style: GoogleFonts.inter(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SvgPicture.asset(
                isSelected ? checkedIcon : uncheckedIcon,
                width: 14.w,
                height: 14.h,
              ),
            ],
          ),
        ),
      ),
    );
  }

}