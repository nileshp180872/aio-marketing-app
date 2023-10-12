import 'dart:async';

import 'package:aio/infrastructure/db/schema/case_study.dart';
import 'package:aio/utils/app_loading.mixin.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../config/app_constants.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../../infrastructure/network/model/case_studies_response.dart';
import '../../../infrastructure/network/model/portfolio_response.dart';
import '../../../utils/utils.dart';
import '../../project_list/model/project_list_model.dart';
import '../../project_list/provider/project_list.provider.dart';

class GlobalSearchController extends GetxController with AppLoadingMixin {
  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  /// Provider
  final _provider = ProjectListProvider();

  /// Search controller
  TextEditingController searchController = TextEditingController();

  /// Focus node
  FocusNode searchFocusNode = FocusNode();

  /// search text
  String _search = "";

  /// search text
  RxString _searchMsg = "".obs;

  /// timer to check when user stops typing.
  Timer? searchOnStoppedTyping;

  // Database helper
  late DatabaseHelper _dbHelper;

  /// Paged view
  final PagingController<int, ProjectListModel> pagingController =
      PagingController(firstPageKey: 1);

  /// logger
  final logger = Logger();

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();
    _addPageViewListener();
    _initialiseFields();
    super.onInit();
  }

  /// Initialise fields
  void _initialiseFields() {
    hideLoading();
    pagingController.appendLastPage([]);
    searchFocusNode.requestFocus();
  }

  /// Add page view listener
  void _addPageViewListener() {
    pagingController.addPageRequestListener((pageKey) async {
      if (await Utils.isConnected()) {
        _getAllDataFromNetwork(pageKey);
      } else {
        _getAllDataFromDb(pageKey);
      }
    });
  }

  /// Get data depend on [_portfolioEnum].
  void _getAllDataFromDb(int pageKey) {
    Future.wait<List<dynamic>>([
      _dbHelper.getPortfolioBySearch(pageKey - 1, search: _search),
      _dbHelper.getCaseStudyBySearch(pageKey - 1, search: _search),
    ]).then((value) {
      if (value.isNotEmpty) {
        try {
          List<ProjectListModel> projectList = [];
          List<Portfolio> portfolioList = value[0] as List<Portfolio>;
          List<CaseStudy> caseStudyList =
              value.length > 1 ? value[1] as List<CaseStudy> : [];

          for (Portfolio element in portfolioList) {
            projectList.add(ProjectListModel(
                id: element.portfolioId,
                autoIncrementId: element.portfolioAutoIncrementId,
                projectName: element.portfolioProjectName,
                projectImage: element.images,
                urlLink: element.portfolioLink,
                viewType: AppConstants.portfolio));
          }

          for (CaseStudy element in caseStudyList) {
            projectList.add(ProjectListModel(
                id: element.caseStudyId,
                autoIncrementId: element.caseStudyAutoIncrementId,
                projectName: element.caseStudyProjectName,
                projectImage: element.images,
                viewType: AppConstants.caseStudy));
          }

          final isLastPage =
              projectList.length < AppConstants.paginationPageLimit;

          if (isLastPage) {
            pagingController.appendLastPage(projectList);
          } else {
            final nextPageKey = pageKey + AppConstants.paginationPageLimit;
            pagingController.appendPage(projectList, nextPageKey);
          }
        } catch (ex) {
          logger.e(ex);
        }
      } else {
        pagingController.appendLastPage([]);
      }
    });
  }

  /// Get data depend on [_portfolioEnum].
  void _getAllDataFromNetwork(int pageKey) {
    Future.wait<List<ProjectListModel>>([
      _getPortfolios(pageKey),
      _getCaseStudies(pageKey),
    ]).then((value) {
      if (value.isNotEmpty) {
        try {
          List<ProjectListModel> projectList = [];
          projectList.addAll(value[0]);
          projectList.addAll(value.length > 1 ? value[1] : []);
          final isLastPage =
              projectList.length < (AppConstants.paginationPageLimit);

          if (isLastPage) {
            pagingController.appendLastPage(projectList);
          } else {
            final nextPageKey = pageKey + 1;
            pagingController.appendPage(projectList, nextPageKey);
          }
        } catch (ex) {
          logger.e(ex);
        }
      }
    });
  }

  @override
  void onClose() {
    searchOnStoppedTyping?.cancel();
    super.onClose();
  }

  /// Get portfolio API.
  Future<List<ProjectListModel>> _getPortfolios(int pageKey) async {
    final response = await _provider.getAllPortfolios(
        offset: pageKey,
        search: _search,
        technologies: [],
        domains: [],
        screens: []);
    if (response.data != null) {
      if (response.statusCode == 200) {
        return await _portfolioAPISuccess(response, pageKey);
      } else {
        _domainAPIError(response);
        return [];
      }
    }
    return [];
  }

  /// Domain error
  ///
  /// required [response] response.
  void _domainAPIError(dio.Response response) {
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

  /// Set user searchable input
  void setSearch(String value) {
    _search = value;
    const duration = Duration(
        milliseconds:
            800); // set the duration that you want call search() after that.
    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping?.cancel();
    }
    searchOnStoppedTyping =
        Timer(duration, () => _searchDataBasedOnUserInput(value));
  }

  /// Search data based on user input.
  void _searchDataBasedOnUserInput(String search) async {
    Get.log("search $_search");
    pagingController.refresh();
  }

  /// on project click
  ///
  /// required [model] instance of ProjectListModel.
  void onProjectClick(ProjectListModel model, int index) {
    if (model.viewType == AppConstants.portfolio) {
      Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
        RouteArguments.screenName: model.projectName,
        RouteArguments.projectId: model.id,
        RouteArguments.index: index,
        RouteArguments.projectList: pagingController.itemList,
      });
    } else {
      Get.toNamed(Routes.CASE_STUDY_NEW, arguments: {
        RouteArguments.screenName: model.projectName,
        RouteArguments.projectId: model.id,
        RouteArguments.index: index,
        RouteArguments.projectList: pagingController.itemList,
      });
    }
  }

  /// Portfolio API success
  ///
  /// required [response] response.
  Future<List<ProjectListModel>> _portfolioAPISuccess(
      dio.Response response, int pageKey) async {
    try {
      final leadershipResponse = PortfolioResponse.fromJson(response.data);
      if ((leadershipResponse.data ?? []).isNotEmpty) {
        List<ProjectListModel> newItems = [];
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
                casestudyThumbnailImage: (images.first.split(",")[0]??""),
                overView: element.domainName,
                description: element.description,
                technologies: technologies.join(","),
                urlLink: element.urlLink,
                viewType: AppConstants.portfolio);
            newItems.add(model);
          } catch (ex) {
            logger.e(ex);
          }
        });
        return newItems;
      }
    } catch (ex) {
      pagingController.error = ex;
      return [];
    }
    return [];
  }

  /// Get case studies API.
  Future<List<ProjectListModel>> _getCaseStudies(int pageKey) async {
    final response = await _provider.getCaseStudies(
        offset: pageKey, search: _search, domains: [], technologies: []);
    if (response.data != null) {
      if (response.statusCode == 200) {
        return await _caseStudyAPISuccess(response, pageKey);
      } else {
        _domainAPIError(response);
        return [];
      }
    }
    return [];
  }

  /// Portfolio API success
  ///
  /// required [response] response.
  Future<List<ProjectListModel>> _caseStudyAPISuccess(
      dio.Response response, int pageKey) async {
    try {
      final leadershipResponse = CaseStudiesResponse.fromJson(response.data);
      if ((leadershipResponse.data ?? []).isNotEmpty) {
        List<ProjectListModel> newItems = [];
        (leadershipResponse.data ?? []).forEach((element) async {
          try {
            final model = Utils.getProjectDetailFromCaseStudy(element);
            newItems.add(model);
          } catch (ex) {
            logger.e(ex);
          }
        });
        return newItems;
      }
    } catch (ex) {
      pagingController.error = ex;
    }
    return [];
  }
}
