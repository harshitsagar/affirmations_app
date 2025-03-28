import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/my_list_controller.dart';

class MyListView extends GetView<MyListController> {
  const MyListView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyListView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MyListView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
