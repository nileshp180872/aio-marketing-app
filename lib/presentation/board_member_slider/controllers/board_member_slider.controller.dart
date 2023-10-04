import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/leadership.dart';
import '../model/member_model.dart';

class BoardMemberSliderController extends GetxController {
  // Database helper
  late DatabaseHelper _dbHelper;

  // Logger
  final logger = Logger();

  /// List of board members.
  RxList<MemberModel> lstMembers = RxList();

  /// Page controller.
  PageController pageController =
      PageController(keepPage: true, initialPage: 0);

  /// Store true if next item available from the list.
  RxBool enableNext = false.obs;

  /// Shoes previous project available from the list.
  RxBool enablePrevious = false.obs;

  @override
  void onInit() {
    _prepareMembers();
    super.onInit();
  }

  /// Prepare members.
  void _prepareMembers() async {
    _dbHelper = GetIt.I<DatabaseHelper>();

    final teamLeaders = await _dbHelper.getAllTeamLeaders();

    lstMembers.clear();

    for (Leadership leadership in teamLeaders) {
      lstMembers.add(MemberModel(
        introduction: leadership.description,
        position: leadership.designation,
        memberName: leadership.leaderName,
      ));
    }

    lstMembers.refresh();
    await Future.delayed(Duration(milliseconds: 300),);
    _checkForActionButtons();
  }

  /// Navigate to next page.
  void goToNextPage() {
    if (enableNext.isTrue) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut);
      _checkForActionButtons();
    }
  }

  void onPageChange(int page){
    _checkForActionButtons();
  }

  /// Navigate to previous page.
  void goToPreviousPage() {
    if (enablePrevious.isTrue) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut);
      _checkForActionButtons();
    }
  }

  /// Enable/Disable action buttons.
  void _checkForActionButtons() {
    enableNext.value =( pageController.page??0).round() < lstMembers.length - 1;

    enablePrevious.value = (pageController.page??0).round() > 0;
  }
}
