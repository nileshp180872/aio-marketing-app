import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/utils/app_loading.mixin.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../filter/model/filter_menu.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../model/project_list_model.dart';

class ProjectListController extends GetxController with AppLoadingMixin {
  /// Project list view type enum
  ProjectListTypeEnum _projectListTypeEnum = ProjectListTypeEnum.DOMAIN;

  /// Screen viewing type enum
  PortfolioEnum _portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.workPortfolio.obs;

  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  /// Filter applied
  RxBool filterApplied = false.obs;

  // Database helper
  late DatabaseHelper _dbHelper;

  // Logger
  final logger = Logger();

  /// Filter menu
  FilterMenu filterModel = FilterMenu();

  @override
  void onInit() {
    _getArguments();
    super.onInit();
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    _dbHelper = GetIt.I<DatabaseHelper>();

    if (Get.arguments != null) {
      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;

      _projectListTypeEnum = Get.arguments[RouteArguments.projectListType] ??
          ProjectListTypeEnum.DOMAIN;

      screenTitle.value = _portfolioEnum == PortfolioEnum.PORTFOLIO
          ? AppStrings.workPortfolio
          : AppStrings.caseStudy;
    }

    _preparePortfolio();
  }

  /// Prepare portfolio
  void _preparePortfolio() async {
    showLoading();
    final portfolio = await _dbHelper.getAllPortfolios();
    for (Portfolio element in portfolio) {
      projectList.add(ProjectListModel(
        id: element.portfolioId,
        projectName: element.portfolioProjectName,
      ));
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      hideLoading();
    });
  }

  /// Prepare case study
  void _prepareCaseStudy() async {
    showLoading();
    final portfolio = await _dbHelper.getAllPortfolios();
    for (Portfolio element in portfolio) {
      projectList.add(ProjectListModel(
        id: element.portfolioId,
        projectName: element.portfolioProjectName,
      ));
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      hideLoading();
    });
  }

  /// Prepare portfolio
  void _filterPortfolioData(
      String domains, String screens, String technologies) async {
    try {
      showLoading();
      final portfolio = await _dbHelper.filterPortfolioDataForFilter(
          domains: domains, screens: screens, technologies: technologies);
      for (Portfolio element in portfolio) {
        projectList.add(ProjectListModel(
          id: element.portfolioId,
          projectName: element.portfolioProjectName,
        ));
      }
      Future.delayed(const Duration(milliseconds: 400), () {
        hideLoading();
      });
    } catch (ex) {
      logger.e(ex);
      Future.delayed(const Duration(milliseconds: 400), () {
        hideLoading();
      });
    }
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
      RouteArguments.filterData: filterModel,
      RouteArguments.portfolioEnum: _portfolioEnum,
    });

    if (filterResponse != null) {
      filterModel = filterResponse as FilterMenu;
      projectList.clear();
      _filterDataBasedOnSelectedItem();
    }
  }

  /// filter data
  void _filterDataBasedOnSelectedItem() {
    showLoading();

    final selectedDomains = filterModel.domains;
    final selectedPlatforms = filterModel.platform;
    final selectedTechnologies = filterModel.technologies;

    filterApplied.value = selectedDomains.isNotEmpty ||
        selectedTechnologies.isNotEmpty ||
        selectedPlatforms.isNotEmpty;

    if (filterApplied.value) {
      final strSelectedDomains = selectedDomains.join(",");
      final strSelectedScreens = selectedPlatforms.join(",");
      final strSelectedTechnologies = selectedTechnologies.join(",");
      _filterPortfolioData(
          strSelectedDomains, strSelectedScreens, strSelectedTechnologies);
    } else {
      _getAllData();
    }
  }

  /// Get all data
  void _getAllData() {
    if (_portfolioEnum == PortfolioEnum.PORTFOLIO) {
      _preparePortfolio();
    } else {
      _prepareCaseStudy();
    }
  }
}

enum ProjectListTypeEnum {
  DOMAIN,
  TECHNOLOGY,
  MOBILE,
}
