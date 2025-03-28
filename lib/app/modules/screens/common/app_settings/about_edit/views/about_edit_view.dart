import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/about_edit_controller.dart';

class AboutEditView extends GetView<AboutEditController> {
  const AboutEditView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AboutEditView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AboutEditView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
