import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/share_screen_controller.dart';

class ShareScreenView extends GetView<ShareScreenController> {
  const ShareScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ShareScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ShareScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
