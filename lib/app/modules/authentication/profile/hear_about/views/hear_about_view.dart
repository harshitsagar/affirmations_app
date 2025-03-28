import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/hear_about_controller.dart';

class HearAboutView extends GetView<HearAboutController> {
  const HearAboutView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HearAboutView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'HearAboutView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
