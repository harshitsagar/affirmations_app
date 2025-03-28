import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/restore_controller.dart';

class RestoreView extends GetView<RestoreController> {
  const RestoreView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('RestoreView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'RestoreView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
