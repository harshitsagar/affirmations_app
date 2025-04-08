import 'dart:ui';
import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/add_entry_controller.dart';

class AddEntryView extends GetView<AddEntryController> {
  const AddEntryView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      // This makes it appear like a bottom sheet with rounded corners
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 0, sigmaY: 0),
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 15),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // The gray bar at the top
              Container(
                width: 60,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 45),

              Image.asset(
                  addEntryImage,
                  height: 154,
                  width: 182
              ),

              const SizedBox(height: 24),

              Text(
                "How do you feel right now?",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                ),
              ),

              const SizedBox(height: 16),

              Text(
                "Take a moment to check in with yourself.\nAdd an entry into Journal.",
                textAlign: TextAlign.center,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),

              const SizedBox(height: 40),

              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    controller.onAddEntry();
                    Get.back(); // Close sheet
                    Get.toNamed('/journal');
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                  ),
                  child: Text(
                    'Add Entry',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              TextButton(
                onPressed: () {
                  controller.onDontAskMeAgain();
                  Get.back();
                },
                child: Text(
                  "Don’t Ask Me Again",
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    decoration: TextDecoration.underline,
                    color: Colors.black,
                  ),
                ),
              ),

              SizedBox(height: 16,),
            ],
          ),
        ),
      ),
    );
  }
}
