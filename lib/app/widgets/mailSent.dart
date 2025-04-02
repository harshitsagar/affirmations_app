import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MailSent extends StatelessWidget {
  const MailSent({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: Container(
          width: MediaQuery.of(context).size.width * 0.89,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, left: 16, right: 16, bottom: 5),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [

                      Text(
                        'Mail Sent',
                        style: GoogleFonts.inter(
                          color: const Color(0xff12121D),
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      const SizedBox(height: 12),
                      SizedBox(
                        width: 300,
                        child: Text(
                          "A link has been sent to your registered email to reset your password.",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Color(0xff12121D),
                            height: 1.4,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(16),
                    bottomRight: Radius.circular(16),
                  ),
                  // border: Border.all(color: Colors.grey.shade300, width: 1.5),
                ),
                child: Expanded(
                  child: TextButton(
                    onPressed: () {
                      Get.back();
                      Get.offAllNamed('/login');
                    },
                    style: TextButton.styleFrom(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          bottomLeft: Radius.circular(12),
                        ),
                      ),
                      padding: const EdgeInsets.all(20),
                      backgroundColor: Colors.black,
                    ),
                    child: Text(
                      'Okay',
                      style: GoogleFonts.openSans(
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
}


