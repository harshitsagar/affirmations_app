import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:affirmations_app/app/widgets/customAppbar.dart';
import '../controllers/journal_controller.dart';

class JournalReminder extends GetView<JournalController> {
  const JournalReminder({super.key});

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

              const SizedBox(height: 30),

              // Title
              Text(
                'Set journal writing reminders',
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),

              const SizedBox(height: 32),

              // Time Selection Container
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(16),
                ),
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildTimeSelector(
                      context,
                      'Start At',
                      "am",
                      controller.startTime,
                          () => controller.selectStartTime(context),
                      isAM: true,
                    ),
                    const SizedBox(height: 25),
                    _buildTimeSelector(
                      context,
                      'End At',
                      "pm",
                      controller.endTime,
                          () => controller.selectEndTime(context),
                      isAM: false,
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // Next Button
              Padding(
                padding: const EdgeInsets.only(bottom: 50),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.navigateToHearAboutScreen,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: Text(
                      'Next',
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
      VoidCallback onTap, {
        required bool isAM,
      }) {
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
            final isDefaultTime = time.value.hour == (isAM ? 0 : 12) &&
                time.value.minute == 0;
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
              height: 50,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(15),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$hour:$minute ',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: isDefaultTime
                                ? Colors.grey
                                : Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: period,
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black, // Always black
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    clockIcon,
                    color: Colors.black,
                    width: 24,
                    height: 24,
                  ),
                ],
              ),
            );
          }),
        ),
      ],
    );
  }

}