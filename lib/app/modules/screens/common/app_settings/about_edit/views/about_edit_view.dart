import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/about_edit_controller.dart';

class AboutEditView extends GetView<AboutEditController> {
  const AboutEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                const CustomAppBar(title: "Edit About You"),

                const SizedBox(height: 30),

                // Name
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Name*",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),

                const SizedBox(height: 12),
                _buildTextField(controller.nameController, "Name"),

                const SizedBox(height: 24),

                // Email
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                const SizedBox(height: 12),
                _buildTextField(controller.emailController, "Email"),

                const SizedBox(height: 24),

                // Age
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Age",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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

                const SizedBox(height: 30),

                // Gender
                Text(
                  "Gender",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 12),
                _buildGenderOption('Female'),
                const SizedBox(height: 20),
                _buildGenderOption('Male'),
                const SizedBox(height: 20),
                _buildGenderOption('Non-Binary'),
                const SizedBox(height: 20),
                _buildGenderOption('Prefer not to say'),

                const SizedBox(height: 30),

                // Save button
                Padding(
                  padding: const EdgeInsets.only(bottom: 40, top: 16),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
                      child: Text(
                        'Save',
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

  Widget _buildTextField(TextEditingController controller, String hintText) {
    return SizedBox(
      height: 40,
      child: TextFormField(
        controller: controller,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }

  Widget _buildAgeOption(String ageGroup) {
    return Obx(() => GestureDetector(
      onTap: () => controller.selectAgeGroup(ageGroup),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
        ),
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
    ));
  }

  Widget _buildGenderOption(String gender) {
    return Obx(() => GestureDetector(
      onTap: () => controller.selectGender(gender),
      child: Container(
        width: double.infinity,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
    ));
  }
  
}
