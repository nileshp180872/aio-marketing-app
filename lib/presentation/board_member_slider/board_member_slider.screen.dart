import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/board_member_slider/view/member_tile_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

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
        body: Column(
      children: [
        buildCustomAppBar(title: AppStrings.teamLeadership),
        const SizedBox(height: 34,),
        Expanded(child: _buildPagedView()),
        const SizedBox(height: 34,),
      ],
    ));
  }

  /// Build page view.
  Widget _buildPagedView() {
    return PageView.builder(
        itemCount: _controller.lstMembers.length,
        itemBuilder: (_, index) {return MemberTileWidget();});
  }
}
