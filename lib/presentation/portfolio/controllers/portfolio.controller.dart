import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/project_list/controllers/project_list.controller.dart';
import 'package:get/get.dart';

import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../infrastructure/navigation/routes.dart';

class PortfolioController extends GetxController {
  /// Screen viewing type enum
  PortfolioEnum portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.workPortfolio.obs;

  /// domain list
  List<String> lstDomains = [
    AppStrings.domainIndustry,
    "Domain1",
    "Domain2",
    "Domain3"
  ];

  /// technologies list
  List<String> lstTechnologies = [
    AppStrings.technologyStack,
    "Technology1",
    "Technology2",
    "Technology3"
  ];

  /// mobile web
  List<String> lstMobileWeb = [
    AppStrings.mobileWeb,
    "Mobile1",
    "Mobile2",
    "Mobile3"
  ];

  RxString selectedDomains = AppStrings.domainIndustry.obs;

  RxString selectedTechnologies = AppStrings.technologyStack.obs;

  RxString selectedMobileWeb = AppStrings.mobileWeb.obs;

  @override
  void onInit() {
    _getArguments();
    super.onInit();
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    if (Get.arguments != null) {
      portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;
    }
    _setupScreen();
  }

  /// prepare screen based on screen type.
  void _setupScreen() {
    if (portfolioEnum == PortfolioEnum.PORTFOLIO) {
      screenTitle.value = AppStrings.workPortfolio;
      _prepareMobileWeb();
    } else {
      screenTitle.value = AppStrings.caseStudy;
    }

    _prepareDomains();
    _prepareTechnologyStack();
  }

  /// Prepare domains list
  void _prepareDomains() {}

  /// Prepare technology stack
  void _prepareTechnologyStack() {}

  /// Prepare mobile web
  void _prepareMobileWeb() {}

  void setDomain(String? value) {
    selectedDomains.value = value ?? "";

    _navigateToProjectLists(
        screenName: selectedDomains.value,
        projectListTypeEnum: ProjectListTypeEnum.DOMAIN);
  }

  void setTechnology(String? value) {
    selectedTechnologies.value = value ?? "";

    _navigateToProjectLists(
        screenName: selectedTechnologies.value,
        projectListTypeEnum: ProjectListTypeEnum.TECHNOLOGY);
  }

  void setMobileWeb(String? value) {
    selectedMobileWeb.value = value ?? "";

    _navigateToProjectLists(
        screenName: selectedMobileWeb.value,
        projectListTypeEnum: ProjectListTypeEnum.MOBILE);
  }

  /// Navigate to project listing screen
  void _navigateToProjectLists(
      {required String screenName,
      required ProjectListTypeEnum projectListTypeEnum}) {
    if (portfolioEnum == PortfolioEnum.PORTFOLIO) {
      Get.toNamed(Routes.PROJECT_LIST, arguments: {
        RouteArguments.portfolioEnum: portfolioEnum,
        RouteArguments.screenName: screenName,
        RouteArguments.projectListType: projectListTypeEnum,
      });
    } else {
      Get.toNamed(Routes.PROJECT_LIST, arguments: {
        RouteArguments.portfolioEnum: portfolioEnum,
        RouteArguments.screenName: screenName,
        RouteArguments.projectListType: projectListTypeEnum,
      });
    }
  }
}

enum PortfolioEnum { PORTFOLIO, CASE_STUDY }
