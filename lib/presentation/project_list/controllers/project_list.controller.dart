import 'package:aio/config/app_constants.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/utils/app_loading.mixin.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/case_study.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../filter/model/filter_menu.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../model/project_list_model.dart';

class ProjectListController extends GetxController with AppLoadingMixin {
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

  /// Paged view
  final PagingController<int, ProjectListModel> pagingController =
      PagingController(firstPageKey: 0);

  @override
  void onInit() {
    _getArguments();
    _addPageViewListener();
    super.onInit();
  }

  /// Add page view listener
  void _addPageViewListener() {
    pagingController.addPageRequestListener((pageKey) {
      _getAllData(pageKey);
    });
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    _dbHelper = GetIt.I<DatabaseHelper>();

    if (Get.arguments != null) {
      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;

      screenTitle.value = _portfolioEnum == PortfolioEnum.PORTFOLIO
          ? AppStrings.workPortfolio
          : AppStrings.caseStudy;
    }
  }

  /// Prepare portfolio
  void _preparePortfolio(int pageKey) async {
    String strSelectedDomains = "";
    String strSelectedScreens = "";
    String strSelectedTechnologies = "";
    if (filterApplied.value) {
      strSelectedDomains = filterModel.domains.join(",");
      strSelectedScreens = filterModel.platform.join(",");
      strSelectedTechnologies = filterModel.technologies.join(",");
    }
    final portfolio = await _dbHelper.getPortfolioWithImage(pageKey,
        domains: strSelectedDomains,
        screens: strSelectedScreens,
        filterApplied: filterApplied.value,
        technologies: strSelectedTechnologies);
    final isLastPage = portfolio.length < AppConstants.paginationPageLimit;
    List<ProjectListModel> newProjectList = [];
    for (Portfolio element in portfolio) {
      newProjectList.add(ProjectListModel(
          id: element.portfolioId,
          autoIncrementId: element.portfolioAutoIncrementId,
          projectName: element.portfolioProjectName,
          projectImage: element.images,
          viewType: AppConstants.portfolio));
    }
    if (isLastPage) {
      pagingController.appendLastPage(newProjectList);
    } else {
      final nextPageKey = pageKey + newProjectList.length;
      pagingController.appendPage(newProjectList, nextPageKey);
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      hideLoading();
    });
  }

  /// Prepare case study
  void _prepareCaseStudy(int pageKey) async {
    String strSelectedDomains = "";
    String strSelectedTechnologies = "";
    if (filterApplied.value) {
      strSelectedDomains = filterModel.domains.join(",");
      strSelectedTechnologies = filterModel.technologies.join(",");
    }
    final caseStudies = await _dbHelper.getCaseStudyWithImage(pageKey,
        domains: strSelectedDomains,
        filterApplied: filterApplied.value,
        technologies: strSelectedTechnologies);
    final isLastPage = caseStudies.length < AppConstants.paginationPageLimit;
    List<ProjectListModel> newProjectList = [];
    for (CaseStudy element in caseStudies) {
      newProjectList.add(ProjectListModel(
          id: element.caseStudyId,
          autoIncrementId: element.caseStudyAutoIncrementId,
          projectName: element.caseStudyProjectName,
          projectImage: element.images,
          viewType: AppConstants.caseStudy));
    }
    if (isLastPage) {
      pagingController.appendLastPage(newProjectList);
    } else {
      final nextPageKey = pageKey + newProjectList.length;
      pagingController.appendPage(newProjectList, nextPageKey);
    }
    Future.delayed(const Duration(milliseconds: 400), () {
      hideLoading();
    });
  }

  /// on project click
  ///
  /// required [model] instance of ProjectListModel.
  void onProjectClick(ProjectListModel model, int index) {
    Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
      RouteArguments.screenName: model.projectName,
      RouteArguments.projectId: model.id,
      RouteArguments.index: index,
      RouteArguments.projectList: pagingController.itemList,
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
      _filterDataBasedOnSelectedItem();
    }
  }

  /// filter data
  void _filterDataBasedOnSelectedItem() {
    final selectedDomains = filterModel.domains;
    final selectedPlatforms = filterModel.platform;
    final selectedTechnologies = filterModel.technologies;

    Get.log("selectedDomains ${selectedDomains.length}");

    filterApplied.value = selectedDomains.isNotEmpty ||
        selectedTechnologies.isNotEmpty ||
        selectedPlatforms.isNotEmpty;

    pagingController.refresh();
  }

  /// Get data depend on [_portfolioEnum].
  void _getAllData(int pageKey) {
    if (_portfolioEnum == PortfolioEnum.PORTFOLIO) {
      _preparePortfolio(pageKey);
    } else {
      _prepareCaseStudy(pageKey);
    }
  }
}

enum ProjectListTypeEnum {
  DOMAIN,
  TECHNOLOGY,
  MOBILE,
}
