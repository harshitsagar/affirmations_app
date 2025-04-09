import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [

              // Top progress bar
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // Streak circle
                    Stack(
                      alignment: Alignment.center,
                      children: [

                        SizedBox(
                          width: 48,
                          height: 48,
                          child: Obx(() =>
                              CircularProgressIndicator(
                                value: controller.streakProgress.value,
                                strokeWidth: 6,
                                backgroundColor: Colors.white,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.orange),
                              )),
                        ),

                        Positioned(
                          top: 15,
                          left: 12,
                          child: Obx(() =>
                              Text(
                                '${controller.currentStreak.value}',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              )),
                        ),

                        // Fire icon
                        Positioned(
                          right: 9,
                          child: Image.asset(
                            fireIcon,
                            width: 14,
                            height: 14,
                          ),
                        ),

                      ],
                    ),

                    // Progress indicator
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: Container(
                          width: 30,
                          height: 40,
                          padding: EdgeInsets.symmetric(horizontal: 24,
                              vertical: 8),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Obx(() =>
                                  Text(
                                    '${controller.currentAffirmationCount
                                        .value}',
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                              Obx(() =>
                                  Text(
                                    '/${controller.dailyGoal.value}',
                                    style: GoogleFonts.inter(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),

                              const SizedBox(width: 8),
                              // Add spacing between text and progress bar
                              Expanded(
                                child: Obx(() =>
                                    LinearProgressIndicator(
                                      value: controller.progressValue.value,
                                      backgroundColor: Colors.grey[200],
                                      valueColor: const AlwaysStoppedAnimation<
                                          Color>(Color(0xFFFF6B8B)),
                                      minHeight: 6,
                                      borderRadius: BorderRadius.circular(30),
                                    )),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    // Premium icon
                    Container(
                      width: 48,
                      height: 48,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          premiumIcon1,
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Affirmation text
              GestureDetector(
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! > 0) {
                    controller.previousAffirmation();
                  } else if (details.primaryVelocity! < 0) {
                    controller.nextAffirmation();
                  }
                },
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 266),
                    child: Obx(() =>
                        Text(
                          controller.currentAffirmation.value,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1.4,
                          ),
                        )),
                  ),
                ),
              ),

              Spacer(),

              // Bottom buttons
              Padding(
                padding: const EdgeInsets.only(left: 116, right: 116, top: 100),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // bottom sheet to share .....
                    GestureDetector(
                      child: Image.asset(
                        shareIcon,
                        width: 24,
                        height: 24,
                      ),
                    ),

                    SizedBox(width: 24,),

                    GestureDetector(
                      onTap: () {
                        controller.toggleFavorite();
                      },
                      child: Obx(() => Image.asset(
                        controller.isCurrentFavorite() ? favoriteIcon2 : favoriteIcon1,
                        width: 48,
                        height: 48,
                      )),
                    ),

                    SizedBox(width: 24,),

                    // mute / unmute icon .....
                    GestureDetector(
                      onTap: () {
                        controller.toggleAudio();
                      },
                      child: Obx(() {
                        if (controller.isAudioMuted.value) {
                          return Image.asset(muteIcon, width: 24, height: 24);
                        } else if (controller.isAudioPlaying.value) {
                          return Image.asset(unMuteIcon, width: 24, height: 24);
                        } else {
                          return Image.asset(muteIcon, width: 24, height: 24); // or use a different icon for "ready to play"
                        }
                      }),
                    ),

                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 20, right: 20, top: 100, bottom: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [

                        // myList .....
                        GestureDetector(
                          onTap: () {

                          },
                          child: Image.asset(
                            mylistIcon,
                            width: 48,
                            height: 48,
                          ),
                        ),

                        SizedBox(width: 16,),

                        // journal screen ....
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed(Routes.JOURNAL);
                          },
                          child: Image.asset(
                            journalIcon,
                            width: 48,
                            height: 48,
                          ),
                        ),

                      ],
                    ),

                    // settings .....
                    GestureDetector(
                      onTap: () {
                        Get.toNamed(Routes.SETTINGS);
                      },
                      child: Image.asset(
                        settingsIcon,
                        width: 48,
                        height: 48,
                      ),
                    ),

                  ],
                ),
              )


            ],
          ),
        ),
      ),
    );
  }
}