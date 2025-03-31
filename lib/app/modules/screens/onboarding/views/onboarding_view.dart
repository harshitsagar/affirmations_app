import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/modules/screens/onboarding/views/onboardingPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/onboarding_controller.dart';

class OnboardingView extends GetView<OnboardingController> {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {

    Get.put(OnboardingController());

    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              bgImage,
              fit: BoxFit.cover,
            ),
          ),

          // Content with SafeArea
          SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                    controller: controller.pageController, // Link PageController
                    onPageChanged: (index) => controller.currentPage.value = index,
                    children: [
                      OnboardingPage(
                        title: "Welcome to Your Affirmations Journey!",
                        description: "Elevate your thinking with life-changing affirmations.",
                        imagePath: onboardingImage1,
                      ),
                      OnboardingPage(
                        title: "Your Daily Affirmations to Better Day",
                        description: "Swipe through daily affirmations, favourite the ones that inspire you, and listen to soothing audio readings.",
                        imagePath: onboardingImage2,
                      ),
                      OnboardingPage(
                        title: "Personalize Your Experience to Mindfulness",
                        description: "Let's make this yours. Take a moment to share who you are and what you need.",
                        imagePath: onboardingImage3,
                      ),
                    ],
                  ),
                ),

                // Custom Indicator & Next Button Row
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 130, right: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Page Indicator
                      Expanded(
                        child: Center(
                          child: Obx(() => Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: List.generate(
                              controller.pageCount,
                                  (index) => AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                width: controller.currentPage.value == index ? 20 : 10, // Elongated for active
                                height: 10,
                                margin: const EdgeInsets.symmetric(horizontal: 4),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: controller.currentPage.value == index
                                      ? Colors.black  // Active (Black)
                                      : Colors.grey.withOpacity(0.5),  // Inactive (Grey)
                                ),
                              ),
                            ),
                          )),
                        ),
                      ),

                      const SizedBox(width: 50),

                      // Next Button
                      Obx(() => TextButton(
                        onPressed: controller.nextPage,
                        child: Text(
                          controller.currentPage.value == controller.pageCount - 1
                              ? "Get Started"
                              : "Next",
                          style: const TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Color(0xff1E1E1E),
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
