import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../project_list/model/project_list_model.dart';

class GlobalSearchController extends GetxController {
  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  /// Search controller
  TextEditingController searchController = TextEditingController();

  /// Focus node
  FocusNode searchFocusNode = FocusNode();

  /// search text
  String _search = "";

  /// timer to check when user stops typing.
  Timer? searchOnStoppedTyping;

  // Database helper
  late DatabaseHelper _dbHelper;

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();
    super.onInit();
  }

  @override
  void onClose() {
    searchOnStoppedTyping?.cancel();
    super.onClose();
  }

  /// Set user searchable input
  void setSearch(String value) {
    _search = value;
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel(); // clear timer
    }
    searchOnStoppedTyping =
        Timer(duration, () => _searchDataBasedOnUserInput(value));
  }

  /// Search data based on user input.
  void _searchDataBasedOnUserInput(String search) async {
    projectList.clear();
    final portfolio = await _dbHelper.getAllPortfolios();
    for (Portfolio element in portfolio) {
      projectList.add(ProjectListModel(
        id: element.portfolioId,
        projectName: element.portfolioProjectName,
      ));
    }
  }

  /// on project click
  ///
  /// required [model] instance of ProjectListModel.
  void onProjectClick(ProjectListModel model, int index) {
    Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
      RouteArguments.screenName: model.projectName,
      RouteArguments.projectId: model.id,
    });
  }
}
