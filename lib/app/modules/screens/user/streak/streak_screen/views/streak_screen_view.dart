import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/streak_screen_controller.dart';

class StreakScreenView extends GetView<StreakScreenController> {
  const StreakScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StreakScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'StreakScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
