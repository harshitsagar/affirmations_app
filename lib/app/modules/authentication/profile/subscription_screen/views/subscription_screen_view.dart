import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/subscription_screen_controller.dart';

class SubscriptionScreenView extends GetView<SubscriptionScreenController> {
  const SubscriptionScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage2),
            fit: BoxFit.contain,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                      icon: Image.asset(crossIcon, height: 24),
                      onPressed: controller.onCancelPressed,
                    ),

                    Text(
                      'Cancel',
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 60),

                // Title
                Text(
                  'Unlock Premium Access',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  height: 172,
                  width: 224,
                  child: Image.asset(
                    crownIcon,
                  ),
                ),

                SizedBox(height: 50,),

                // Features List
                _buildFeatureItem('Removes All Ads'),
                _buildFeatureItem('Unlock All Themes'),
                _buildFeatureItem('3 Free Streak Freezes'),
                _buildFeatureItem('Lifetime Access'),

                const Spacer(),

                // Go Premium Button (matching your sample style)
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: controller.onGoPremiumPressed,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      '\$19.99 Go Premium',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // Terms & Conditions (matching your text button style)
                TextButton(
                  onPressed: controller.onTermsPressed,
                  child: Text(
                    'Terms & Conditions',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      decoration: TextDecoration.underline,
                      decorationColor: Colors.black,
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 80, bottom: 25),
      child: Row(
        children: [
          Image.asset(
            blackTickIcon,
            height: 24,
            width: 24,
          ),
          const SizedBox(width: 12),
          Text(
            text,
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}