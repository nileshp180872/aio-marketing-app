import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/board_member_slider/view/member_tile_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
        InkWell(
          onTap: _controller.goToPreviousPage,
          child: const SizedBox(
              width: AppValues.sideMargin,
              child: Center(child: Icon(Icons.arrow_back_ios_new))),
        ),
        Expanded(
          child: PageView.builder(
              controller: _controller.pageController,
              itemCount: _controller.lstMembers.length,
              itemBuilder: (_, index) {
                return MemberTileWidget(
                  memberModel: _controller.lstMembers[index],
                );
              }),
        ),
        InkWell(
          onTap: _controller.goToNextPage,
          child: const SizedBox(
              width: AppValues.sideMargin,
              child: Center(child: Icon(Icons.arrow_forward_ios_rounded))),
        ),
      ],
    );
  }
}
