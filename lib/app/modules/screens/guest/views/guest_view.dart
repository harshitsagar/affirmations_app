import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/guest_controller.dart';

class GuestView extends GetView<GuestController> {
  const GuestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GuestView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'GuestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
