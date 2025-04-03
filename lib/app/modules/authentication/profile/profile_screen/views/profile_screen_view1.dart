// profile_screen_view1.dart
import 'package:affirmations_app/app/modules/authentication/profile/profile_screen/views/profile_screen_view2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affirmations_app/app/data/components/images_path.dart';

import '../controllers/profile_screen_controller.dart';

class ProfileScreenView1 extends GetView<ProfileScreenController> {
  const ProfileScreenView1({super.key});

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
              // Skip button
              Align(
                alignment: Alignment.topRight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 60),
                  child: TextButton(
                    onPressed: () {
                      Get.to(() => const ProfileScreenView2());
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
                ),
              ),

              // Title
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Text(
                  'How old are you?',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
              ),

              const SizedBox(height: 32),

              // Age options
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildAgeOption('18 or Under'),
                      const SizedBox(height: 20),
                      _buildAgeOption('19 - 24'),
                      const SizedBox(height: 20),
                      _buildAgeOption('25 - 34'),
                      const SizedBox(height: 20),
                      _buildAgeOption('35 - 44'),
                      const SizedBox(height: 20),
                      _buildAgeOption('45 - 54'),
                      const SizedBox(height: 20),
                      _buildAgeOption('55 - 64'),
                      const SizedBox(height: 20),
                      _buildAgeOption('65 or Older'),
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
                      if (controller.selectedAgeGroup.isNotEmpty) {
                        Get.to(() => const ProfileScreenView2());
                      }
                      else{
                        Get.snackbar(
                          'Note',
                          'Please select an age group',
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

  Widget _buildAgeOption(String ageGroup) {
    return SizedBox(
      height: 45,
      child: Obx(() => GestureDetector(
        onTap: () => controller.selectAgeGroup(ageGroup),
        child: Container(
          height: 56,
          margin: const EdgeInsets.symmetric(horizontal: 0),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(30),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  ageGroup,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                Image.asset(
                  controller.selectedAgeGroup.value == ageGroup
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