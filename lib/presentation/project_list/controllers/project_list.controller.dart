import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
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

  /// Filter applied
  RxBool filterApplied = false.obs;

// Database helper
  late DatabaseHelper _dbHelper;

  @override
  void onInit() {
    _getArguments();
    super.onInit();
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    _dbHelper = GetIt.I<DatabaseHelper>();

    if (Get.arguments != null) {
      screenTitle.value =
          Get.arguments[RouteArguments.screenName] ?? AppStrings.domainIndustry;
      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;
      _projectListTypeEnum = Get.arguments[RouteArguments.projectListType] ??
          ProjectListTypeEnum.DOMAIN;
    }

    _preparePortfolio();
  }

  /// Prepare portfolio
  void _preparePortfolio() async {
    final portfolio = await _dbHelper.getAllPortfolios();
    for (Portfolio element in portfolio) {
      projectList.add(ProjectListModel(
        id: element.portfolioId,
        projectName: element.portfolioProjectName,
      ));
    }

    Future.delayed(const Duration(milliseconds: 1400),(){
      projectList.refresh();
    });

  }

  /// on project click
  ///
  /// required [model] instance of ProjectListModel.
  void onProjectClick(ProjectListModel model) {
    Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
      RouteArguments.screenName: model.projectName,
      RouteArguments.projectId: model.id,
      RouteArguments.projectListType: _projectListTypeEnum,
      RouteArguments.portfolioEnum: _portfolioEnum,
    });
  }

  /// filter screen.
  void onFilterClick() async {
    final filterResponse = await Get.toNamed(Routes.FILTER, arguments: {
      RouteArguments.filterApplied: filterApplied.value,
    });

    if (filterResponse != null) {
      filterApplied.value = filterResponse;
    }
  }
}

enum ProjectListTypeEnum {
  DOMAIN,
  TECHNOLOGY,
  MOBILE,
}
