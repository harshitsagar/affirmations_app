import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/subscription_screen_controller.dart';

class SubscriptionScreenView extends GetView<SubscriptionScreenController> {
  const SubscriptionScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SubscriptionScreenView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SubscriptionScreenView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
