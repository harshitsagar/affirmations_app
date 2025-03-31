import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  final String title;
  final String description;
  final String imagePath;

  const OnboardingPage({
    super.key,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Ensuring Image Scales Properly
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.42, // Keeps a uniform image height
            child: Image.asset(
              imagePath,
              fit: BoxFit.contain, // Ensures full image is visible without distortion
            ),
          ),

          const SizedBox(height: 52),

          SizedBox(
            width: 320,
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                height: 1.3,
                color: Color(0xff12121D),
              ),
            ),
          ),

          const SizedBox(height: 24),

          SizedBox(
            width: 330,
            child: Text(
              description,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.black,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

