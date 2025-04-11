import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
            padding: EdgeInsets.only(left: 20.w, right: 20.w, top: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomAppBar(title: "Edit About You"),

                SizedBox(height: 30.h),

                // Name
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Name*",
                    // style: Theme.of(context).textTheme.headlineLarge!.copyWith(),
                    style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),

                SizedBox(height: 12.h),

                _buildTextField(controller.nameController, "Name"),

                SizedBox(height: 24.h),

                // Email
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Email",
                    style: GoogleFonts.inter(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: Colors.black),
                  ),
                ),
                SizedBox(height: 12.h),
                _buildTextField(controller.emailController, "Email"),

                SizedBox(height: 24.h),

                // Age
                Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    "Age",
                    style: GoogleFonts.inter(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(height: 12.h),
                _buildAgeOption('18 or Under'),
                SizedBox(height: 18.h),
                _buildAgeOption('19 - 24'),
                SizedBox(height: 18.h),
                _buildAgeOption('25 - 34'),
                SizedBox(height: 18.h),
                _buildAgeOption('35 - 44'),
                SizedBox(height: 18.h),
                _buildAgeOption('45 - 54'),
                SizedBox(height: 18.h),
                _buildAgeOption('55 - 64'),
                SizedBox(height: 18.h),
                _buildAgeOption('65 or Older'),

                SizedBox(height: 30.h),

                // Gender
                Text(
                  "Gender",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 12.h),
                _buildGenderOption('Female'),
                SizedBox(height: 18.h),
                _buildGenderOption('Male'),
                SizedBox(height: 18.h),
                _buildGenderOption('Non-Binary'),
                SizedBox(height: 18.h),
                _buildGenderOption('Prefer not to say'),

                SizedBox(height: 30.h),

                // Save button
                Padding(
                  padding: EdgeInsets.only(bottom: 40.h, top: 16.h),
                  child: SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.saveDetails,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 12.h),
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
      height: 40.h,
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
            color: Colors.grey,
          ),
          contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.r),
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
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              ageGroup,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Image.asset(
              controller.selectedAgeGroup.value == ageGroup
                  ? selectedIcon
                  : unselectedIcon,
              width: 15.w,
              height: 15.h,
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
        height: 40.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.5),
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              gender,
              style: GoogleFonts.inter(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Image.asset(
              controller.selectedGender.value == gender
                  ? selectedIcon
                  : unselectedIcon,
              width: 15.w,
              height: 15.h,
            ),
          ],
        ),
      ),
    ));
  }
  
}
