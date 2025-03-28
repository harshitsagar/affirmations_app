import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/contact_admin_controller.dart';

class ContactAdminView extends GetView<ContactAdminController> {
  const ContactAdminView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ContactAdminView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ContactAdminView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
