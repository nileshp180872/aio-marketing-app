import 'package:aio/config/app_strings.dart';
import 'package:aio/infrastructure/navigation/routes.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/splash.controller.dart';

class SplashScreen extends GetView<SplashController> {
  SplashController _controller = Get.find<SplashController>(tag: Routes.SPLASH);

  SplashScreen({Key? key}) : super(key: key);

  late TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Center(
        child: _buildCenterLogo(),
      ),
    );
  }

  /// Build center logo widget.
  Widget _buildCenterLogo() {
    return Text(
      AppStrings.appName,
      style: textTheme.bodyLarge,
    );
  }
}
