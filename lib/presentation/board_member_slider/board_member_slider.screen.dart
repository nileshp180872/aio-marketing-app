import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/board_member_slider/view/member_tile_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_values.dart';
import '../../infrastructure/navigation/routes.dart';
import 'controllers/board_member_slider.controller.dart';

class BoardMemberSliderScreen extends GetView<BoardMemberSliderController>
    with AppFeature {
  BoardMemberSliderController _controller =
      Get.find(tag: Routes.BOARD_MEMBER_SLIDER);

  BoardMemberSliderScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => Column(
          children: [
            buildCustomAppBar(title: AppStrings.teamLeadership),
            const SizedBox(
              height: AppValues.size_34,
            ),
            Expanded(child: _buildPagedView()),
            const SizedBox(
              height: AppValues.size_20,
            ),
          ],
        ),
      ),
    );
  }

  /// Build page view.
  Widget _buildPagedView() {
    return Row(
      children: [
        if(_controller.lstMembers.isNotEmpty)
          InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            onTap: _controller.enablePrevious.isTrue
                ? _controller.goToPreviousPage
                : null,
            child: SizedBox(
                width: AppValues.sideMargin,
                height: AppValues.sideMargin,
                child: Center(
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: _controller.enablePrevious.isTrue
                          ? AppColors.colorSecondary
                          : AppColors.colorSecondary.withOpacity(0.5),
                    ))),
          ),
        Expanded(
          child: _controller.lstMembers.isNotEmpty?PageView.builder(
              controller: _controller.pageController,
              itemCount: _controller.lstMembers.length,
              onPageChanged: _controller.onPageChange,
              itemBuilder: (_, index) {
                return MemberTileWidget(
                  memberModel: _controller.lstMembers[index],
                );
              }):_buildNoDataWidget(),
        ),
        if(_controller.lstMembers.isNotEmpty)
          InkWell(
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            onTap:
            _controller.enableNext.isTrue ? _controller.goToNextPage : null,
            child: SizedBox(
                width: AppValues.sideMargin,
                child: Center(
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: _controller.enableNext.isTrue
                          ? AppColors.colorSecondary
                          : AppColors.colorSecondary.withOpacity(0.5),
                    ))),
          ),
      ],
    );
  }

  /// Build no data widget
  Widget _buildNoDataWidget() {
    return const Center(child: Text(AppStrings.noDataFound));
  }
}
