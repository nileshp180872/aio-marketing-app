import 'dart:async';

import 'package:aio/infrastructure/db/schema/case_study.dart';
import 'package:aio/presentation/project_detail/controllers/project_detail.controller.dart';
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
import '../../project_list/model/project_list_model.dart';

class GlobalSearchController extends GetxController {
  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  /// Search controller
  TextEditingController searchController = TextEditingController();

  /// Focus node
  FocusNode searchFocusNode = FocusNode();

  /// search text
  String _search = "";

  /// timer to check when user stops typing.
  Timer? searchOnStoppedTyping;

  // Database helper
  late DatabaseHelper _dbHelper;

  /// Paged view
  final PagingController<int, ProjectListModel> pagingController =
      PagingController(firstPageKey: 0);

  /// logger
  final logger = Logger();

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();
    _addPageViewListener();
    super.onInit();
  }

  /// Add page view listener
  void _addPageViewListener() {
    pagingController.addPageRequestListener((pageKey) {
      _getAllData(pageKey);
    });
  }

  /// Get data depend on [_portfolioEnum].
  void _getAllData(int pageKey) {
    Future.wait<List<dynamic>>([
      _dbHelper.getPortfolioBySearch(pageKey, search: _search),
      _dbHelper.getCaseStudyBySearch(pageKey, search: _search),
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
            final nextPageKey = pageKey + projectList.length;
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
    if (search.isNotEmpty) {
      pagingController.refresh();
    }
  }

  /// on project click
  ///
  /// required [model] instance of ProjectListModel.
  void onProjectClick(ProjectListModel model, int index) {
    Get.toNamed(Routes.PROJECT_DETAIL, arguments: {
      RouteArguments.screenName: model.projectName,
      RouteArguments.projectId: model.id,
      RouteArguments.searchValue: _search,
      RouteArguments.autoIncrementValue: model.autoIncrementId,
      RouteArguments.detailType: DetailType.search,
    });
  }
}
