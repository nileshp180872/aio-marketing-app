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
      ProjectListModel(
          projectName: 'Project 1', projectImage: "assets/images/project1.png"),
      ProjectListModel(
          projectName: 'Project 2', projectImage: "assets/images/project2.png"),
      ProjectListModel(
          projectName: 'Project 3', projectImage: "assets/images/project3.png"),
      ProjectListModel(
          projectName: 'Project 4', projectImage: "assets/images/project1.png"),
      ProjectListModel(
          projectName: 'Project 5', projectImage: "assets/images/project3.png"),
      ProjectListModel(
          projectName: 'Project 6', projectImage: "assets/images/project1.png"),
      ProjectListModel(
          projectName: 'Project 7', projectImage: "assets/images/project2.png"),
      ProjectListModel(
          projectName: 'Project 8', projectImage: "assets/images/project1.png"),
      ProjectListModel(
          projectName: 'Project 9', projectImage: "assets/images/project1.png"),
      ProjectListModel(
          projectName: 'Project 10',
          projectImage: "assets/images/project1.png"),
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
