import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import 'package:flutter/material.dart';
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
                padding: const EdgeInsets.only(left: 20, top: 20),
                child: CustomAppBar(title: ""),
              ),

              const SizedBox(height: 30),

              // Title Text
              Text(
                "Let's choose your theme",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 32),

              // Theme Options with "Aa" text inside the boxes
              Obx(() => Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(controller.themeImages.length, (index) {
                  bool isSelected = controller.selectedTheme.value == index;

                  return GestureDetector(
                    onTap: () => controller.selectTheme(index),
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Container(
                          height: 168,
                          width: 115,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              image: AssetImage(controller.themeImages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Center( // Ensuring "Aa" is centered
                            child: Text(
                              "Aa",
                              style: GoogleFonts.inter(
                                fontSize: 25,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ),
                        ),
                        if (isSelected)
                          Positioned(
                            top: 8,
                            right: 8,
                            child: Image.asset(
                                tickIcon,
                                width: 24,
                                height: 24),
                          ),
                      ],
                    ),
                  );
                }),
              )),

              const Spacer(),

              // Next Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: ElevatedButton(
                  onPressed: () {
                    Get.offAllNamed(Routes.JOURNAL1);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text(
                    "Next",
                    style: GoogleFonts.inter(
                      fontSize: 18,
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
