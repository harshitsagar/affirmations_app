import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/modules/screens/common/share_screen/controllers/share_screen_controller.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, top: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [

                    // Streak circle
                    GestureDetector(
                      onTap: () {
                        controller.navigateToStreakScreen();
                      },
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 45.w,
                            height: 40.h,
                            child: Obx(() =>
                                CircularProgressIndicator(
                                  value: controller.streakProgress.value,
                                  strokeWidth: 6.w,
                                  backgroundColor: Colors.white,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.orange),
                                )),
                          ),

                          Positioned(
                            top: 13.h,
                            left: 12.w,
                            child: Obx(() =>
                                Text(
                                  '${controller.currentStreak.value}',
                                  style: GoogleFonts.inter(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),

                          // Fire icon
                          Positioned(
                            right: 9.w,
                            child: Image.asset(
                              fireIcon,
                              width: 14.w,
                              height: 14.w,
                            ),
                          ),

                        ],
                      ),
                    ),

                    // Progress indicator
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 18.w),
                        child: Container(
                          width: 30.w,
                          height: 30.h,
                          padding: EdgeInsets.symmetric(horizontal: 24.w,
                              vertical: 8.h),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
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
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  )),
                              Obx(() =>
                                  Text(
                                    '/${controller.dailyGoal.value}',
                                    style: GoogleFonts.inter(
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),

                              SizedBox(width: 8.w),
                              // Add spacing between text and progress bar
                              Expanded(
                                child: Obx(() =>
                                    LinearProgressIndicator(
                                      value: controller.progressValue.value,
                                      backgroundColor: Colors.grey[200],
                                      valueColor: const AlwaysStoppedAnimation<
                                          Color>(Color(0xFFFF6B8B)),
                                      minHeight: 6.h,
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
                      width: 45.w,
                      height: 40.h,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                      ),
                      child: Center(
                        child: Image.asset(
                          premiumIcon1,
                          width: 24.w,
                          height: 24.h,
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
                    padding: EdgeInsets.only(
                        left: 20.w, right: 20.w, top: 200.h),
                    child: Obx(() =>
                        Text(
                          controller.currentAffirmation.value,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                            height: 1.4.h,
                          ),
                        )),
                  ),
                ),
              ),

              Spacer(),

              // Bottom buttons
              Padding(
                padding: EdgeInsets.only(left: 100.w, right: 100.w, bottom: 100.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [

                    // bottom sheet to share .....
                    GestureDetector(
                      onTap: () {
                        controller.showShareBottomSheet();
                      },
                      child: Image.asset(
                        shareIcon,
                        width: 24.w,
                        height: 24.h,
                      ),
                    ),

                    SizedBox(width: 24.w),

                    GestureDetector(
                      onTap: () {
                        controller.toggleFavorite();
                      },
                      child: Obx(() => Image.asset(
                        controller.isCurrentFavorite() ? favoriteIcon2 : favoriteIcon1,
                        width: 48.w,
                        height: 48.h,
                      )),
                    ),

                    SizedBox(width: 20.w),

                    // mute / unmute icon .....
                    GestureDetector(
                      onTap: () {
                        controller.toggleAudio();
                      },
                      child: Obx(() {
                        if (controller.isAudioMuted.value) {
                          return Image.asset(muteIcon, width: 24.w, height: 24.h);
                        } else if (controller.isAudioPlaying.value) {
                          return Image.asset(unMuteIcon, width: 24.w, height: 24.h);
                        } else {
                          return Image.asset(muteIcon, width: 24.w, height: 24.h); // or use a different icon for "ready to play"
                        }
                      }),
                    ),

                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(
                    left: 20.w, right: 20.w, bottom: 20.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [

                    Row(
                      children: [

                        // myList .....
                        GestureDetector(
                          onTap: () {
                            controller.navigateToMyList();
                          },
                          child: Image.asset(
                            mylistIcon,
                            width: 48.w,
                            height: 48.h,
                          ),
                        ),

                        SizedBox(width: 16.w),

                        // journal screen ....
                        GestureDetector(
                          onTap: () {
                            // Get.toNamed(Routes.JOURNAL);
                          },
                          child: Image.asset(
                            journalIcon,
                            width: 48.w,
                            height: 48.h,
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
                        width: 48.w,
                        height: 48.h,
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