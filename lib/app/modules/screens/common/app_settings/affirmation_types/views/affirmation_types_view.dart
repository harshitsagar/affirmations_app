import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/affirmation_types_controller.dart';

class AffirmationTypesView extends GetView<AffirmationTypesController> {
  const AffirmationTypesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AffirmationTypesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AffirmationTypesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
