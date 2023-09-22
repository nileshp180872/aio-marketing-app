import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/member_model.dart';

class BoardMemberSliderController extends GetxController {
  /// List of board members.
  RxList<MemberModel> lstMembers = RxList();

  PageController pageController = PageController();

  @override
  void onInit() {
    _prepareMembers();
    super.onInit();
  }

  /// Prepare members.
  void _prepareMembers() {
    lstMembers.addAll([
      MemberModel(),
      MemberModel(),
      MemberModel(),
      MemberModel(),
      MemberModel(),
    ]);
  }

  /// Navigate to next page.
  void goToNextPage() {
    pageController.nextPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.linearToEaseOut);
  }

  /// Navigate to previous page.
  void goToPreviousPage() {
    pageController.previousPage(
        duration: const Duration(milliseconds: 600),
        curve: Curves.linearToEaseOut);
  }
}
