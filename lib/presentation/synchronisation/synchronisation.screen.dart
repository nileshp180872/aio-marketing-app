import 'package:aio/infrastructure/navigation/routes.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_strings.dart';
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
      body: Obx(
        () => SizedBox(
          width: double.infinity,
          child: _controller.isNetworkEnable.value
              ? _buildSynchroniseWidget()
              : _buildNoInternetWidget(),
        ),
      ),
    );
  }

  /// Build synchronise widget.
  Widget _buildSynchroniseWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          _buildSuccessAnimationWidget(),
          _buildSynchroniseText(),
          const SizedBox(
            height: 20,
          ),
          _buildWarningText()
        ],
      );

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

  /// Build synchronisation text
  Widget _buildNoInternetText() {
    return Text(
      "You are offline!",
      style: _textTheme.headlineLarge,
    );
  }

  /// Build warning text
  Widget _buildWarningText() => Text(
        "Please do not close this screen. You will automatically redirect to home screen after this synchronisation completes.",
        style: _textTheme.bodyMedium,
      );

  /// Build offline data text
  Widget _buildOfflineDataText() => Text(
        "Please connect to internet to synchronize data.",
        style: _textTheme.bodyMedium,
      );

  /// Build no internet widget.
  Widget _buildNoInternetWidget() => Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildNoInternetText(),
          const SizedBox(
            height: 20,
          ),
          _buildOfflineDataText(),
          const SizedBox(
            height: 30,
          ),
          _buildHomeButton()
        ],
      );

  /// Build home button
  Widget _buildHomeButton() {
    return InkWell(
      onTap: _controller.onGetBack,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            AppStrings.goToHome,
            style: _textTheme.labelLarge
                ?.copyWith(fontFamily: AppConstants.poppins),
          )),
    );
  }
}
