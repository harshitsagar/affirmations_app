import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/contact_admin_controller.dart';

class ContactAdminView extends GetView<ContactAdminController> {
  const ContactAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2), // bgImage from images_path.dart
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                CustomAppBar(
                  title: "Contact Admin",
                  onBackPressed: () => Get.back(),
                ),

                SizedBox(height: 20.h),

                Text(
                  "How we can help you to have a better experience on our app?",
                  style: GoogleFonts.inter(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),

                SizedBox(height: 20.h),

                Obx(() {
                  return TextField(
                    controller: controller.messageController,
                    maxLines: 8,
                    maxLength: 300,
                    decoration: InputDecoration(
                      hintText: "Type here...",
                      hintStyle: GoogleFonts.inter(
                        fontSize: 16.sp,
                        color: Color(0xFFD9D9D9),
                      ),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.9),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(24.r),
                        borderSide: BorderSide.none,
                      ),
                      contentPadding: EdgeInsets.all(16.r),
                      counterText: "(${controller.charCount.value}/300)",
                      counter: Padding(
                        padding: EdgeInsets.only(top: 5.h), // Adjust the padding as needed
                        child: Text(
                          "(${controller.charCount.value}/300)",
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            color: Color(0xFFA9A9A9),
                          ),
                        ),
                      ),
                    ),
                  );
                }),

                SizedBox(height: 20.h),

                Obx(() {
                  final enabled = controller.isSendEnabled.value;
                  return SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: controller.sendMessage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                        enabled ? Colors.black : Color(0xFF757575),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        padding: EdgeInsets.symmetric(vertical: 10.h),
                      ),
                      child: Text(
                        "Send",
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  );
                }),

                SizedBox(height: 10.h),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
