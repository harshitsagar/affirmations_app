import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/journal_home_controller.dart';

class JournalHomeView extends GetView<JournalHomeController> {
  const JournalHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JournalHomeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JournalHomeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
