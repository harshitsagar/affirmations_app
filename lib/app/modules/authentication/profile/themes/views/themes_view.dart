import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/themes_controller.dart';

class ThemesView extends GetView<ThemesController> {
  const ThemesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ThemesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ThemesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
