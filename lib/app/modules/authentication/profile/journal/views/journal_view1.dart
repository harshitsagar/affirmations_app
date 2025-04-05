import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/journal_controller.dart';

class JournalView1 extends GetView<JournalController> {
  const JournalView1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage), // Replace with your actual image path
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 100),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  // Text content
                  Padding(
                    padding: const EdgeInsets.only(top: 30.0),
                    child: Text(
                      'Track your growth',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: SizedBox(
                      width: double.infinity,
                      height: 68,
                      child: Text(
                        'Track your mood before and after affirmations to witness your transformation, and share your feelings in the Notes field.',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 40),
              child: SizedBox(
                height: 400,
                width: double.infinity,
                child: Image.asset(
                  journalHome, // Replace with your actual image path
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const Spacer(),

            // Button at the bottom
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, bottom: 50),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    // Add navigation logic here....
                    Get.toNamed(Routes.JOURNAL2);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(
                    'Let\'s Go',
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
    );
  }
}