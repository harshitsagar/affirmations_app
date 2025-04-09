// profile_screen_view2.dart
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';

import '../controllers/profile_screen_controller.dart';

class ProfileScreenView2 extends GetView<ProfileScreenController> {
  const ProfileScreenView2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Header with back and skip buttons
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Back button
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios),
                      onPressed: () {
                        Get.back(); // Navigates back to previous screen
                      },
                      iconSize: 24,
                    ),
                    // Skip button
                    TextButton(
                      onPressed: () {
                        Get.toNamed(Routes.AFFIRMATION_REMINDER);
                      },
                      child: Text(
                        'Skip',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'What best represents you?',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Gender options
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildGenderOption('Female'),
                      const SizedBox(height: 20),
                      _buildGenderOption('Male'),
                      const SizedBox(height: 20),
                      _buildGenderOption('Non-Binary'),
                      const SizedBox(height: 20),
                      _buildGenderOption('Prefer not to say'),
                    ],
                  ),
                ),
              ),

              // Next button
              Padding(
                padding: const EdgeInsets.only(bottom: 40),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      if (controller.selectedGender.isNotEmpty) {
                        Get.toNamed(Routes.AFFIRMATION_REMINDER);
                      }
                      else{
                        Get.snackbar(
                          'Note',
                          'Please select gender',
                          snackPosition: SnackPosition.TOP,
                          backgroundColor: Colors.transparent,
                          colorText: Colors.black,
                        );
                      }
                    },
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
    );
  }

  Widget _buildGenderOption(String gender) {
    return SizedBox(
      height: 45,
      child: Obx(() => GestureDetector(
        onTap: () {
          if (controller.selectedGender.value == gender) {
            controller.selectGender('');
          } else {
            controller.selectGender(gender);
          }
        },
        child: Container(
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.only(top: 12, bottom: 12, left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  gender,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  controller.selectedGender.value == gender
                      ? selectedIcon
                      : unselectedIcon,
                  width: 15,
                  height: 15,
                ),
              ],
            ),
          ),
        ),
      )),
    );
  }

}