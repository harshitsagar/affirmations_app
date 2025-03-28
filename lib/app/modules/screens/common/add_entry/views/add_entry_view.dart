import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_entry_controller.dart';

class AddEntryView extends GetView<AddEntryController> {
  const AddEntryView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddEntryView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AddEntryView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
