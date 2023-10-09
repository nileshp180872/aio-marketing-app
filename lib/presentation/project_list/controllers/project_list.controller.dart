import 'package:aio/config/app_constants.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/infrastructure/network/model/portfolio_response.dart';
import 'package:aio/utils/app_loading.mixin.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/case_study.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/network/model/case_studies_response.dart';
import '../../../utils/utils.dart';
import '../../filter/model/filter_menu.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../model/project_list_model.dart';
import '../provider/project_list.provider.dart';

class ProjectListController extends GetxController with AppLoadingMixin {
  /// Screen viewing type enum
  PortfolioEnum _portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.workPortfolio.obs;

  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  /// Provider
  final _provider = ProjectListProvider();

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
      PagingController(firstPageKey: 1);

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
  void _preparePortfolioFromDb(int pageKey) async {
    String strSelectedDomains = "";
    String strSelectedScreens = "";
    String strSelectedTechnologies = "";
    if (filterApplied.value) {
      strSelectedDomains = filterModel.domains.join(",");
      strSelectedScreens = filterModel.platform.join(",");
      strSelectedTechnologies = filterModel.technologies.join(",");
    }
    final portfolio = await _dbHelper.getPortfolioWithImage(pageKey -1,
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
  void _prepareCaseStudyFromDb(int pageKey) async {
    String strSelectedDomains = "";
    String strSelectedTechnologies = "";
    if (filterApplied.value) {
      strSelectedDomains = filterModel.domains.join(",");
      strSelectedTechnologies = filterModel.technologies.join(",");
    }
    final caseStudies = await _dbHelper.getCaseStudyWithImage(pageKey-1,
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

    filterApplied.value = selectedDomains.isNotEmpty ||
        selectedTechnologies.isNotEmpty ||
        selectedPlatforms.isNotEmpty;

    pagingController.refresh();
  }

  /// Get data depend on [_portfolioEnum].
  void _getAllData(int pageKey) async {
    final isNetwork = await Utils.isConnected();
    if (_portfolioEnum == PortfolioEnum.PORTFOLIO) {
      if (isNetwork) {
        _getPortfolios(pageKey);
      } else {
        _preparePortfolioFromDb(pageKey);
      }
    } else {
      if (isNetwork) {
        _getCaseStudies(pageKey);
      } else {
        _prepareCaseStudyFromDb(pageKey);
      }
    }
  }

  /// Get portfolio API.
  Future<void> _getPortfolios(int pageKey) async {
    final response = await _provider.getAllPortfolios(
        offset: pageKey,
        technologies: filterModel.technologies,
        screens: filterModel.platform,
        domains: filterModel.domains);
    if (response.data != null) {
      if (response.statusCode == 200) {
        _portfolioAPISuccess(response, pageKey);
      } else {
        _domainAPIError(response);
      }
    }
  }

  /// Portfolio API success
  ///
  /// required [response] response.
  void _portfolioAPISuccess(dio.Response response, int pageKey) async {
    try {
      final leadershipResponse = PortfolioResponse.fromJson(response.data);
      if ((leadershipResponse.data ?? []).isNotEmpty) {
        List<ProjectListModel> newItems = [];
        final isLastPage = (leadershipResponse.data ?? []).length <
            AppConstants.paginationPageLimit;
        (leadershipResponse.data ?? []).forEach((element) async {
          try {
            final images = (element.imageMapping ?? [])
                .map((e) => e.portfolioImage ?? "")
                .toList();

            final technologies = (element.techMapping ?? [])
                .map((e) => e.techName ?? "")
                .toList();
            final model = ProjectListModel(
                id: element.portfolioID,
                projectName: element.projectName,
                networkImages: images,
                overView: element.domainName,
                description: element.description,
                technologies: technologies.join(", "),
                viewType: AppConstants.portfolio);
            newItems.add(model);
          } catch (ex) {
            logger.e(ex);
          }
        });
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (ex) {
      pagingController.error = ex;
    }
  }

  /// Get case studies API.
  Future<void> _getCaseStudies(int pageKey) async {
    try {
      showLoading();
      final response = await _provider.getCaseStudies(
          offset: pageKey,
          domains: filterModel.domains,
          technologies: filterModel.technologies);
      hideLoading();
      if (response.data != null) {
        if (response.statusCode == 200) {
          _caseStudyAPISuccess(response, pageKey);
        } else {
          _domainAPIError(response);
        }
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (ex) {
      pagingController.error = ex.toString();
      hideLoading();
    }
  }

  /// Portfolio API success
  ///
  /// required [response] response.
  void _caseStudyAPISuccess(dio.Response response, int pageKey) async {
    try {
      final leadershipResponse = CaseStudiesResponse.fromJson(response.data);
      if ((leadershipResponse.data ?? []).isNotEmpty) {
        List<ProjectListModel> newItems = [];
        final isLastPage = (leadershipResponse.data ?? []).length <
            AppConstants.paginationPageLimit;
        (leadershipResponse.data ?? []).forEach((element) async {
          try {
            final images = (element.imageMapping ?? [])
                .map((e) => e.casestudiesImage ?? "")
                .toList();
            final technologies = (element.techMapping ?? [])
                .map((e) => e.techName ?? "")
                .toList();
            final model = ProjectListModel(
                id: element.casestudiesID,
                projectName: element.projectName,
                networkImages: images,
                overView: element.domainName,
                description: element.description,
                technologies: technologies.join(","),
                viewType: AppConstants.caseStudy);
            newItems.add(model);
          } catch (ex) {
            logger.e(ex);
          }
        });
        if (isLastPage) {
          pagingController.appendLastPage(newItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(newItems, nextPageKey);
        }
      } else {
        pagingController.appendLastPage([]);
      }
    } catch (ex) {
      pagingController.error = ex;
    }
  }

  /// Domain error
  ///
  /// required [response] response.
  void _domainAPIError(dio.Response response) {
    pagingController.appendLastPage([]);
    final snackBar = SnackBar(
      elevation: 4,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(response.statusMessage ?? ""),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}

enum ProjectListTypeEnum {
  DOMAIN,
  TECHNOLOGY,
  MOBILE,
}
