// journal_reminder_view.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/journal_reminder_controller.dart';

class JournalReminderView extends GetView<JournalReminderController> {
  const JournalReminderView({super.key});

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