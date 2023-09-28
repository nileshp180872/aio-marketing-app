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

  PageController pageController = PageController();

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
