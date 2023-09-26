import 'package:aio/infrastructure/db/database_helper.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_strings.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../../project_list/controllers/project_list.controller.dart';
import '../../project_list/model/project_list_model.dart';

class ProjectDetailController extends GetxController {
  /// Project list view type enum
  ProjectListTypeEnum _projectListTypeEnum = ProjectListTypeEnum.DOMAIN;

  /// Screen viewing type enum
  PortfolioEnum _portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.domainIndustry.obs;

  /// Project reactive model
  Rx<ProjectListModel> projectData = ProjectListModel().obs;

  late DatabaseHelper _dbHelper;

  late String _projectId;

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();

    _getArguments();
    super.onInit();
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    if (Get.arguments != null) {
      screenTitle.value = Get.arguments[RouteArguments.screenName] ?? "";
      _projectId = Get.arguments[RouteArguments.projectId] ?? "";
      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;
      _projectListTypeEnum = Get.arguments[RouteArguments.projectListType] ??
          ProjectListTypeEnum.DOMAIN;

      _prepareProjectDetails();
    }
  }

  /// Navigate to next page.
  void goToNextPage() {}

  /// Navigate to previous page.
  void goToPreviousPage() {}

  /// Get project detail by id.
  void _prepareProjectDetails() async {
    final projectDetail =
        await _dbHelper.getPortfolioById(portfolioId: _projectId);
    if (projectDetail != null) {
      ProjectListModel model = ProjectListModel();
      model.projectName = projectDetail.portfolioProjectName;
      model.description = projectDetail.portfolioProjectDescription;
      model.overView = projectDetail.portfolioDomainName;
      model.technologies = projectDetail.portfolioScreenTypeName;
      projectData.value = model;
    }
  }
}
