import 'package:aio/infrastructure/navigation/routes.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../config/app_assets.dart';
import 'controllers/synchronisation.controller.dart';

class SynchronisationScreen extends GetView<SynchronisationController>
    with AppFeature {
  SynchronisationScreen({Key? key}) : super(key: key);

  final SynchronisationController _controller =
      Get.find(tag: Routes.SYNCHRONISATION);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSuccessAnimationWidget(),
          _buildSynchroniseText(),
          const SizedBox(
            height: 20,
          ),
          _buildWarningText()
        ],
      ),
    ));
  }

  /// Build success animation.
  Widget _buildSuccessAnimationWidget() {
    return Lottie.asset(
      LottieAssets.syncAnimation,
    );
  }

  /// Build synchronisation text
  Widget _buildSynchroniseText() {
    return Text(
      "Synchronise data",
      style: _textTheme.headlineLarge,
    );
  }

  /// Build warning text
  Widget _buildWarningText() => Text(
        "Please do not close this screen. You will automatically redirect to home screen after this synchronisation completes.",
        style: _textTheme.bodyMedium,
      );
}
