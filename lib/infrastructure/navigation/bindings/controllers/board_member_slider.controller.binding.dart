import 'package:get/get.dart';

import '../../../../presentation/board_member_slider/controllers/board_member_slider.controller.dart';
import '../../routes.dart';

class BoardMemberSliderControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BoardMemberSliderController>(
      () => BoardMemberSliderController(),
      tag: Routes.BOARD_MEMBER_SLIDER
    );
  }
}
