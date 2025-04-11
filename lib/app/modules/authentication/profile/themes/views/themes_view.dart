import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../data/components/images_path.dart';
import '../controllers/themes_controller.dart';

class ThemesView extends GetView<ThemesController> {
  const ThemesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ThemesController());

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage), // Default background
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              // Back Button
              Padding(
                padding: EdgeInsets.only(left: 20.w, top: 10.h),
                child: CustomAppBar(title: ""),
              ),

              SizedBox(height: 30.h),

              // Title Text
              Text(
                "Let's choose your theme",
                style: GoogleFonts.inter(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              SizedBox(height: 32.h),

              // Theme Options with "Aa" text inside the boxes
              Obx(() => Padding(
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: List.generate(controller.themeImages.length, (index) {
                    bool isSelected = controller.selectedTheme.value == index;

                    return GestureDetector(
                      onTap: () => controller.selectTheme(index),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            height: 160.h,
                            width: 105.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12.r),
                              image: DecorationImage(
                                image: AssetImage(controller.themeImages[index]),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Center( // Ensuring "Aa" is centered
                              child: Text(
                                "Aa",
                                style: GoogleFonts.inter(
                                  fontSize: 25.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                          if (isSelected)
                            Positioned(
                              top: 8.h,
                              right: 8.w,
                              child: Image.asset(
                                  greenTickIcon,
                                  width: 24.w,
                                  height: 24.h
                              ),
                            ),
                        ],
                      ),
                    );
                  }),
                ),
              )),

              const Spacer(),

              // Next Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.JOURNAL1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.r),
                    ),
                    minimumSize: Size(double.infinity, 45.h),
                  ),
                  child: Text(
                    "Next",
                    style: GoogleFonts.inter(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
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
}
