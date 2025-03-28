import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/freeze_controller.dart';

class FreezeView extends GetView<FreezeController> {
  const FreezeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FreezeView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'FreezeView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
