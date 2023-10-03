import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
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

  late BuildContext _buildContext;
  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    _textTheme = Theme.of(context).textTheme;

    return Scaffold(
      // appBar: buildAppBarWithSearch(),
      floatingActionButton: _buildFAB(),
      body: Obx(
        () => Column(
          children: [
            buildCustomAppBarWithoutTite(),
            const SizedBox(
              height: AppValues.size_34,
            ),
            Expanded(child: _buildBodyWidget()),
            const SizedBox(
              height: AppValues.size_20,
            ),
          ],
        ),
      ),
    );
  }

  /// Build synchronisation FAB.
  FloatingActionButton _buildFAB() {
    return FloatingActionButton(
      onPressed: () => _controller.navigateToSynchronisation(),
      child: const Icon(
        Icons.sync,
        color: Colors.white,
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
        // work/portfolio
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.workPortfolio,
                onClick: _controller.navigateToPortfolio)),
        const SizedBox(
          width: AppValues.size_30,
        ),
        // case study
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.caseStudy,
                onClick: _controller.navigateToCaseStudy)),
        const SizedBox(
          width: AppValues.size_30,
        ),
        // team leadership
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.teamLeadership,
                onClick: _controller.navigateToLeadership)),
        const SizedBox(
          width: AppValues.size_30,
        ),
        // team leadership
        Expanded(
            child: _buildButton(
                buttonText: AppStrings.clientele,
                onClick: _controller.navigateToClientele)),
      ],
    );
  }

  /// Build action button.
  Widget _buildButton(
      {required String buttonText, required Function() onClick}) {
    final screenSize = MediaQuery.of(_buildContext).size;
    final fontSize = screenSize.width > 1024 ? 24.0 : 20.0;
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.lightBlue,
        elevation: 2,
        padding: const EdgeInsets.symmetric(vertical: AppValues.padding_44),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
      ),
      onPressed: onClick,
      child: Center(
        child: Text(
          buttonText,
          style: _textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontFamily: AppConstants.poppins,
              fontSize: fontSize,
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
    return Row(
      children: [
        Expanded(flex: 6, child: _buildOverlayLeftSide()),
        Expanded(flex: 8, child: _buildVideoPlayer()),
      ],
    );
  }

  /// Build overlay widget
  Widget _buildOverlayContainer() {
    return Container(
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
      padding: const EdgeInsets.only(left: AppValues.size_4),
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
                  fontFamily: AppConstants.poppins,
                  color: AppColors.colorSecondary),
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
                  color: AppColors.colorSecondary),
            ),
            const SizedBox(
              height: AppValues.size_16,
            ),
            Text(
              AppStrings.homeOverlayContent3,
              style: _textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                  fontFamily: AppConstants.poppins,
                  color: AppColors.colorSecondary.withOpacity(0.8)),
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
    return Center(
      child: InkWell(
        onTap: _controller.hideOverlayAndLoadVideo,
        child: SvgPicture.asset(SVGAssets.bluePlayIcon),
      ),
    );
  }

  /// Build inquiry button
  Widget _buildInquiryButton() {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.colorPrimary,
          elevation: 2,
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
        onPressed: _controller.navigateToEnquiry,
        child: Text(
          AppStrings.letsDiscussYourIdea,
          style: _textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              fontFamily: AppConstants.poppins,
              color: Colors.white),
        ));
  }
}
