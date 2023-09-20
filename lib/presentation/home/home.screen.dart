import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../utils/user_feature.mixin.dart';
import 'controllers/home.controller.dart';

class HomeScreen extends GetView<HomeController> with AppFeature {
  HomeScreen({Key? key}) : super(key: key);

  final HomeController _controller = Get.find(tag: Routes.HOME);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: buildAppBarWithSearch(),
      floatingActionButton: _buildFAB(),
      body: Obx(() => _buildBodyWidget()),
    );
  }

  /// Build synchronisation FAB.
  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: () => _controller.navigateToSynchronisation(),
      child: const Icon(
        Icons.sync,
        color: Colors.black,
      ),
    );
  }

  /// Build body widget
  Widget _buildBodyWidget() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppValues.sideMargin),
        child: Column(
          children: [
            Expanded(child: _stackIntroContainer()),
            const SizedBox(
              height: AppValues.size_30,
            ),
            _buildBottomActions(),
            const SizedBox(
              height: AppValues.size_30,
            ),
          ],
        ),
      );

  /// build bottom actions
  Widget _buildBottomActions() {
    return Row(
      children: [
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.workPortfolio,
                onClick: _controller.navigateToPortfolio)),
        const SizedBox(
          width: AppValues.size_30,
        ),
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.caseStudy,
                onClick: _controller.navigateToPortfolio)),
        const SizedBox(
          width: AppValues.size_30,
        ),
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.teamLeadership,
                onClick: _controller.navigateToPortfolio)),
      ],
    );
  }

  /// Build action button.
  Widget _buildButton(
      {required String buttonText, required Function() onClick}) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        elevation: 0,
        padding: const EdgeInsets.symmetric(vertical: AppValues.padding_44),
      ),
      onPressed: onClick,
      child: Center(
        child: Text(
          buttonText,
          style: _textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 28,
              color: AppColors.colorSecondary),
        ),
      ),
    );
  }

  /// Build video player widget.
  Widget _buildVideoPlayer() {
    return _controller.videoPlayerController.value.value.isInitialized
        ? Chewie(controller: _controller.chewieController)
        : Container();
  }

  /// Stack intro container
  Widget _stackIntroContainer() {
    return Stack(
      fit: StackFit.expand,
      children: [
        _buildVideoPlayer(),
        if (_controller.overlayEnabled.isTrue) _buildOverlayContainer(),
      ],
    );
  }

  /// Build overlay widget
  Widget _buildOverlayContainer() {
    return Container(
      color: const Color(0xFF00517C).withOpacity(0.75),
      child: Row(
        children: [
          Expanded(child: _buildOverlayLeftSide()),
          Expanded(child: _buildOverlayRightSide())
        ],
      ),
    );
  }

  /// Build overlay left side of the screen.
  Widget _buildOverlayLeftSide() {
    return Padding(
      padding: const EdgeInsets.only(left: AppValues.homeOverlayContentSpacing),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppStrings.homeOverlayContent1,
              style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 32,
                  height: 1.5,
                  color: Colors.white),
            ),
            const SizedBox(
              height: AppValues.size_8,
            ),
            Text(
              AppStrings.homeOverlayContent2,
              style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 32,
                  fontFamily: 'Inter',
                  color: Colors.white),
            ),
            const SizedBox(
              height: AppValues.size_20,
            ),
            Text(
              AppStrings.homeOverlayContent3,
              style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  color: Colors.white.withOpacity(0.8)),
            ),
            const SizedBox(
              height: AppValues.size_20,
            ),
            _buildInquiryButton()
          ]),
    );
  }

  /// Build overlay right side
  Widget _buildOverlayRightSide() {
    return Container(
      child: Center(
        child: InkWell(
          onTap: _controller.hideOverlayAndLoadVideo,
          child: SvgPicture.asset(SVGAssets.bluePlayIcon),
        ),
      ),
    );
  }

  /// Build inquiry button
  Widget _buildInquiryButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorPrimary,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        ),
        onPressed: _controller.navigateToEnquiry,
        child: Text(
          AppStrings.letsDiscussYourIdea,
          style: _textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600, fontSize: 16, color: Colors.white),
        ));
  }
}
