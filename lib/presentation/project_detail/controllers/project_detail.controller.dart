import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:get/get.dart';

import '../../../config/app_strings.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../../project_list/controllers/project_list.controller.dart';

class ProjectDetailController extends GetxController {
  /// Project list view type enum
  ProjectListTypeEnum _projectListTypeEnum = ProjectListTypeEnum.DOMAIN;

  /// Screen viewing type enum
  PortfolioEnum _portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.domainIndustry.obs;

  late String _projectId;

  @override
  void onInit() {
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
    }
  }

  void _prepareProjectDetails() {}
}
