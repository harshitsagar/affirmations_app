import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView( // Added SingleChildScrollView to prevent overflow
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CustomAppBar(
                  title: "",
                  onBackPressed: () => Get.back(),
                ),

                const SizedBox(height: 20),

                // Question 1
                Text(
                  'How do you feel right now?',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 20),

                // Mood options list - removed Expanded since we're using SingleChildScrollView
                SizedBox(
                  height: 350,
                  child: ListView.builder(
                    // physics: const NeverScrollableScrollPhysics(), // Disable scrolling since we have outer scroll
                    itemCount: controller.moods.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final mood = controller.moods[index];
                      return Obx(() {
                        final isSelected = controller.selectedMood.value == mood;
                        return _buildMoodOption(mood, isSelected);
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),

                // Title with character counter in same row
                Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Why do you feel this way?',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    Text(
                      '(${controller.notes.value.length}/${controller.maxNotesLength})',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.black.withOpacity(0.6),
                      ),
                    ),
                  ],
                )),

                const SizedBox(height: 20),

                // TextField
                Obx(() => TextField(
                  controller: TextEditingController(text: controller.notes.value), // Add controller to sync with notes
                  onChanged: controller.updateNotes,
                  maxLines: 4,
                  maxLength: controller.maxNotesLength,
                  decoration: InputDecoration(
                    hintText: 'Add notes here...',
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffA9A9A9),
                    ),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.9),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.all(16),
                    counterText: '', // hides default counter
                  ),
                )),

                const SizedBox(height: 20),

                // Next Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.navigateToNextScreen,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Next',
                        style: GoogleFonts.inter(
                          fontSize: 16,
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

  Widget _buildMoodOption(String mood, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: GestureDetector(
        onTap: () => Get.find<JournalController>().selectMood(mood),
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.6),
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                mood,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SvgPicture.asset(
                isSelected ? checkedIcon : uncheckedIcon,
                width: 14,
                height: 14,
              ),
            ],
          ),
        ),
      ),
    );
  }
}