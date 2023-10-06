import 'package:aio/utils/app_loading.mixin.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/leadership.dart';
import '../../../infrastructure/network/model/leaders_response.dart';
import '../../../utils/utils.dart';
import '../model/member_model.dart';
import '../provider/board_member.provider.dart';

class BoardMemberSliderController extends GetxController with AppLoadingMixin {
  // Database helper
  late DatabaseHelper _dbHelper;

  // Provider
  final _provider = BoardMemberProvider();

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

    if (await Utils.isConnected()) {
      _getLeaders();
    } else {
      getLeadersFromDb();
    }
  }

  void getLeadersFromDb() async {
    final teamLeaders = await _dbHelper.getAllTeamLeaders();

    lstMembers.clear();

    for (Leadership leadership in teamLeaders) {
      lstMembers.add(MemberModel(
          introduction: leadership.description,
          position: leadership.designation,
          memberName: leadership.leaderName,
          leaderImage: leadership.image));
    }
    await Future.delayed(
      Duration(milliseconds: 300),
    );
    _checkForActionButtons();
    lstMembers.refresh();
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

  void onPageChange(int page) {
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
    enableNext.value =
        (pageController.page ?? 0).round() < lstMembers.length - 1;

    enablePrevious.value = (pageController.page ?? 0).round() > 0;
  }

  /// Get leaders leaders
  Future<void> _getLeaders() async {
    showLoading();
    final response = await _provider.getLeaders();
    hideLoading();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _leaderAPISuccess(response);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Domain error
  ///
  /// required [response] response.
  void _domainAPIError(dio.Response response) {
    final snackBar = SnackBar(
      elevation: 4,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(response.statusMessage ?? ""),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }

  /// Leaders API success
  ///
  /// required [response] response.
  void _leaderAPISuccess(dio.Response response) async {
    final leadershipResponse = LeadersResponse.fromJson(response.data);

    if ((leadershipResponse.data ?? []).isNotEmpty) {
      for (LeadersResponseData element in (leadershipResponse.data ?? [])) {
        try {
          String leaderImage = "";
          if ((element.imageMapping ?? []).isNotEmpty) {
            leaderImage = (element.imageMapping ?? []).first.leaderImage ?? "";
          }
          final model = MemberModel(
              memberName: element.leaderNAME,
              position: element.designation,
              introduction: element.description,
              leaderImage: leaderImage);
          lstMembers.add(model);
        } catch (ex) {
          logger.e(ex);
        }
      }
      await Future.delayed(
        Duration(milliseconds: 300),
      );
      _checkForActionButtons();
      lstMembers.refresh();
    }
  }
}
