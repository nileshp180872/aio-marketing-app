import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/synchronisation.controller.dart';

class SynchronisationScreen extends GetView<SynchronisationController> {
  const SynchronisationScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SynchronisationScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SynchronisationScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
