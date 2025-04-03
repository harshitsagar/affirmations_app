import 'package:affirmations_app/app/helpers/utils/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../../../data/components/images_path.dart';
import '../controllers/affirmation_reminder_controller.dart';

class AffirmationReminderView extends GetView<AffirmationReminderController> {
  const AffirmationReminderView({super.key});

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
          padding: const EdgeInsets.only(left: 20, right: 20, top: 60),
          child: Column(
            children: [
              const CustomAppBar(title: ""),
              const SizedBox(height: 20),

              // Title Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      'Choose when to receive your affirmation reminders',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Text(
                      'Reading multiple affirmations a day will help you achieve your goals faster',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 40),

              // Affirmation Counter
              Obx(() => Container(
                width: double.infinity,
                height: 56,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        icon: SvgPicture.asset(
                          minusIcon,
                          width: 24,
                          height: 24,
                        ),
                        onPressed: controller.decrementAffirmations,
                        padding: EdgeInsets.zero,
                      ),
                      Text(
                        controller.affirmationCount.value.toString(),
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      IconButton(
                        icon: SvgPicture.asset(
                          plusIcon,
                          width: 24,
                          height: 24,
                        ),
                        onPressed: controller.incrementAffirmations,
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ),
              )),

              const SizedBox(height: 35),

              // Time Selection Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 16),
                child: Column(
                  children: [
                    _buildTimeSelector(
                      context,
                      'Start At',
                      "am",
                      controller.startTime,
                          () => controller.selectStartTime(context),
                    ),
                    const SizedBox(height: 20),
                    _buildTimeSelector(
                      context,
                      'End At',
                      "pm",
                      controller.endTime,
                          () => controller.selectEndTime(context),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Submit Button
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.savePreferences,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      "Let's Do This!",
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

  Widget _buildTimeSelector(
      BuildContext context,
      String label,
      String period_name,
      Rx<TimeOfDay> time,
      VoidCallback onTap,
      ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        const SizedBox(height: 10),
        GestureDetector(
          onTap: onTap,
          child: Obx(() {
            final isDefaultTime = time.value.hour == 0 && time.value.minute == 0;
            final hour = isDefaultTime
                ? '00'
                : (time.value.hour > 12
                ? (time.value.hour - 12).toString().padLeft(2, '0')
                : time.value.hour.toString().padLeft(2, '0'));
            final minute = time.value.minute.toString().padLeft(2, '0');
            final period = isDefaultTime
                ? period_name
                : (time.value.hour < 12 ? 'am' : 'pm');

            return Container(
              height: 44,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        '$hour:$minute',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: isDefaultTime
                              ? const Color(0xFFA9A9A9)
                              : Colors.black,
                        ),
                      ),
                      if (period.isNotEmpty) ...[
                        const SizedBox(width: 4),
                        Text(
                          period,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ],
                  ),
                  const Icon(Icons.access_time),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }
}