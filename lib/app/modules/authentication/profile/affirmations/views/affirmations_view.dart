import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/affirmations_controller.dart';

class AffirmationsView extends GetView<AffirmationsController> {
  const AffirmationsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AffirmationsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AffirmationsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
