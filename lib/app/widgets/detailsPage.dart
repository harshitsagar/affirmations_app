import 'package:affirmations_app/app/data/components/images_path.dart';
import 'package:affirmations_app/app/helpers/utils/customAppbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoPage extends StatelessWidget {
  final String title;

  const InfoPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(bgImage), // Adjust path as needed
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  CustomAppBar(title: title),

                  const SizedBox(height: 30),

                  Text(
                    "Lorem ipsum dolor sit amet consectetur. Viverra vitae facilisis proin malesuada faucibus libero. Pellentesque sagittis dis non tellus hac imperdiet posuere vulputate. Ultricies pretium fames arcu accumsan turpis facilisi diam pellentesque sagittis.\n\nSit sit egestas sodales in non amet risus. Vitae dolor dictum mauris aliquet. Semper odio rhoncus nec mus. Interdum mauris faucibus eu luctus pretium lectus. Integer sed id mi elit quis lacus eget. Ac enim nibh pretium in imperdiet arcu quis dapibus. Mauris quis leo sit vitae blandit volutpat tempor. Porttitor vulputate enim sit hendrerit vitae vel vitae.\n\nEget nisi leo elementum turpis in malesuada ultricies diam cursus. In nibh sed mauris amet vel. Sagittis fermentum ut viverra id sit semper facilisi ullamcorper. Porttitor ultricies interdum egestas risus.\n\nSit sit egestas sodales in non amet risus. Vitae dolor dictum mauris aliquet. Semper odio rhoncus nec mus. Interdum mauris faucibus eu luctus pretium lectus. Integer sed id mi elit quis lacus eget. Ac enim nibh pretium in imperdiet arcu quis dapibus. Mauris quis leo sit vitae blandit volutpat tempor. Porttitor vulputate enim sit hendrerit vitae vel vitae.", // Add full text here
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xff1A0303),
                    ),
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Usage Example:
// Get.to(() => InfoPage(title: "Terms & Conditions"));
// Get.to(() => InfoPage(title: "Privacy Policy"));

// Navigation in SignupView:
// Get.to(() => InfoPage(title: "Terms & Conditions"));
// Get.to(() => InfoPage(title: "Privacy Policy"));
