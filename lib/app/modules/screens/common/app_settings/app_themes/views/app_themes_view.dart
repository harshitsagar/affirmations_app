import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/app_themes_controller.dart';

class AppThemesView extends GetView<AppThemesController> {
  const AppThemesView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AppThemesView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AppThemesView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
