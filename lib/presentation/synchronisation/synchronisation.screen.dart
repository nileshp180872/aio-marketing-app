import 'package:aio/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/synchronisation.controller.dart';

class SynchronisationScreen extends GetView<SynchronisationController> {

  SynchronisationScreen({Key? key}) : super(key: key);

  final SynchronisationController _controller = Get.find(tag: Routes.SYNCHRONISATION);

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
