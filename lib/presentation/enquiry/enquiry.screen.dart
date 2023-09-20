import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/enquiry.controller.dart';

class EnquiryScreen extends GetView<EnquiryController> {
  const EnquiryScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('EnquiryScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'EnquiryScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
