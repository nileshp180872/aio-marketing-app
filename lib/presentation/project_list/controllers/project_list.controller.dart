import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:get/get.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../model/project_list_model.dart';

class ProjectListController extends GetxController {
  /// Project list view type enum
  ProjectListTypeEnum _projectListTypeEnum = ProjectListTypeEnum.DOMAIN;

  /// Screen viewing type enum
  PortfolioEnum _portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.domainIndustry.obs;

  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  @override
  void onInit() {
    _getArguments();
    super.onInit();
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    if (Get.arguments != null) {
      screenTitle.value =
          Get.arguments[RouteArguments.screenName] ?? AppStrings.domainIndustry;
      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;
      _projectListTypeEnum = Get.arguments[RouteArguments.projectListType] ??
          ProjectListTypeEnum.DOMAIN;
    }

    _populateDataOnScreenFilter();
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
      RouteArguments.projectListType: _projectListTypeEnum,
      RouteArguments.portfolioEnum: _portfolioEnum,
    });
  }

  /// filter screen.
  void onFilterClick() {
    Get.toNamed(Routes.FILTER);
  }
}

enum ProjectListTypeEnum {
  DOMAIN,
  TECHNOLOGY,
  MOBILE,
}
