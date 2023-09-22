import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../project_list/model/project_list_model.dart';

class GlobalSearchController extends GetxController {
  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  TextEditingController searchController = TextEditingController();

  FocusNode searchFocusNode = FocusNode();

  String _search = "";

  @override
  void onInit() {
    _populateDataOnScreenFilter();

    super.onInit();
  }
  void setSearch(String value) {
    _search = value;
  }
  /// Populate data.
  void _populateDataOnScreenFilter() {
    projectList.addAll([
      ProjectListModel(projectName: 'Project 1'),
      ProjectListModel(projectName: 'Project 2'),
      ProjectListModel(projectName: 'Project 3'),
      ProjectListModel(projectName: 'Project 4'),
      ProjectListModel(projectName: 'Project 5'),
      ProjectListModel(projectName: 'Project 6'),
      ProjectListModel(projectName: 'Project 7'),
      ProjectListModel(projectName: 'Project 8'),
      ProjectListModel(projectName: 'Project 9'),
      ProjectListModel(projectName: 'Project 10'),
    ]);
  }

  /// on project click
  ///
  /// required [model] instance of ProjectListModel.
  void onProjectClick(ProjectListModel model) {
    Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
      RouteArguments.screenName: model.projectName,
      // RouteArguments.projectListType: _projectListTypeEnum,
      // RouteArguments.portfolioEnum: _portfolioEnum,
    });
  }
}
