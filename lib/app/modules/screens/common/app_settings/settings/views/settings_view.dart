import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/settings_controller.dart';

class SettingsView extends GetView<SettingsController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2), // from your sample
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Custom AppBar....
                CustomAppBar(title: "Settings"),

                const SizedBox(height: 30),

                // Try Premium Now Container....
                Container(
                  width: double.infinity,
                  height: 104,
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color(0xffB4A4F9),
                        Color(0xFFFFCCEA)
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [

                      Padding(
                        padding: const EdgeInsets.only(left: 5, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          spacing: 5,
                          children: [
                            Text(
                              'Try Premium Now',
                              style: GoogleFonts.inter(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                            Text(
                              'Removes Ads & unlock all themes',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 0,
                        right: 10,
                        child: Image.asset(
                          diamondIcon, // Replace with your asset path
                          width: 70,
                          height: 70,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 34),

                // About You Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'About You',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                    GestureDetector(
                      onTap: () => Get.toNamed(Routes.ABOUT_EDIT),
                      child: Image.asset(editIcon, height: 24, width: 24,)
                    ), // your icon here
                  ],
                ),

                const SizedBox(height: 16),

                // User Info Container
                Obx(() => Container(
                  padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      _buildUserInfoRow('Name', controller.name.value),
                      const Divider(color: Color(0xFFF3F4F6), height: 16),
                      _buildUserInfoRow('Email', controller.email.value.isNotEmpty ? controller.email.value : '--'),
                      const Divider(color: Color(0xFFF3F4F6), height: 16),
                      _buildUserInfoRow('Age', controller.age.value.isNotEmpty ? controller.age.value : '--'),
                      const Divider(color: Color(0xFFF3F4F6), height: 16),
                      _buildUserInfoRow('Gender', controller.gender.value.isNotEmpty ? controller.gender.value : '--'),
                    ],
                  ),
                )),
                const SizedBox(height: 32),

                // Settings Header
                Text(
                  'Settings',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 16),

                // Settings Options Container
                Container(
                  padding: const EdgeInsets.only(left: 5, top: 5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      _buildSettingItem(affirmationTypesIcon, 'Affirmations Types'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(reminderIcon, 'Reminders',),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(appthemeIcon, 'App Theme'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(sharingIcon, 'Refer a Friend'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(reviewIcon, 'Leave us a Review'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(aboutUsIcon, 'About Us'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(termsConditionsIcon, 'Terms & Conditions'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(privacyPolicyIcon, 'Privacy Policy'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(contactAdminIcon, 'Contact Admin'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(faqIcon, 'FAQs'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(logoutIcon, 'Logout'),
                      Divider(color: Color(0xFFF3F4F6), height: 14, thickness: 1,),
                      _buildSettingItem(deleteIcon, 'Delete'),

                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem(String image, String title) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 12),

      leading: Image.asset(image, height: 24, width: 24,),
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      onTap: () => controller.handleSettingTap(title),
    );
  }

}
