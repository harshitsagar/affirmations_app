import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/journal_profile_controller.dart';

class JournalProfileView extends GetView<JournalProfileController> {
  const JournalProfileView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JournalProfileView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JournalProfileView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
