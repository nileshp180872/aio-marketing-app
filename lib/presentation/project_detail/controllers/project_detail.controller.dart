import 'package:aio/infrastructure/db/database_helper.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/presentation/filter/model/filter_menu.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../config/app_constants.dart';
import '../../../config/app_strings.dart';
import '../../../infrastructure/db/schema/case_study.dart';
import '../../../infrastructure/db/schema/portfolio.dart';
import '../../portfolio/controllers/portfolio.controller.dart';
import '../../project_list/model/project_list_model.dart';

class ProjectDetailController extends GetxController {
  /// Screen viewing type enum
  PortfolioEnum _portfolioEnum = PortfolioEnum.PORTFOLIO;

  /// screen title
  RxString screenTitle = AppStrings.domainIndustry.obs;

  /// Project reactive model
  Rx<ProjectListModel> projectData = ProjectListModel().obs;

  late DatabaseHelper _dbHelper;

  late String _projectId;

  late String _searchValue;

  DetailType detailType = DetailType.listing;

  /// technologies
  RxString technologies = "".obs;

  /// Store active image index from current project.
  RxInt activeImageIndex = 0.obs;

  /// Stores active project index from the list.
  RxInt activeProjectIndex = 0.obs;

  /// Store true if next item available from the list.
  RxBool enableNext = false.obs;

  /// Shoes previous project available from the list.
  RxBool enablePrevious = false.obs;

  /// Project images
  RxList<String> images = RxList();

  /// Store true if filter is applied otherwise false.
  bool filterApplied = false;

  /// Filter menu model.
  FilterMenu filterModel = FilterMenu();

  final logger = Logger();

  /// Project list
  RxList<ProjectListModel> projectList = RxList();

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

      activeProjectIndex.value = Get.arguments[RouteArguments.autoIncrementValue] ?? "";

      _searchValue = Get.arguments[RouteArguments.projectId] ?? "";

      detailType = Get.arguments[RouteArguments.detailType] ?? DetailType.listing;

      filterModel = Get.arguments[RouteArguments.filterData] ?? FilterMenu();

      filterApplied = Get.arguments[RouteArguments.filterApplied] ?? false;

      projectList.value = Get.arguments[RouteArguments.projectList] ?? [];

      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;

      _prepareProjectDetails();
    }
  }

  /// Navigate to next page.
  void goToNextPage() {
    if (enableNext.isTrue) {
      activeProjectIndex.value++;
      _prepareProjectDetails();
    }
  }

  /// Navigate to previous page.
  void goToPreviousPage() {
    if (enablePrevious.isTrue) {
      activeProjectIndex.value--;
      _prepareProjectDetails();
    }
  }

  /// Get project detail by id.
  void _prepareProjectDetails() async {
    if(detailType == DetailType.search){
      _getAllData(activeProjectIndex.value);
    }else {
      if (_portfolioEnum == PortfolioEnum.PORTFOLIO) {
        _preparePortfolioData();
      } else {
        _prepareCaseStudyData();
      }
    }
    _checkForActionButtons();
  }

  /// Prepare portfolio data for screen.
  void _preparePortfolioData() async {
    String strSelectedDomains = "";
    String strSelectedScreens = "";
    String strSelectedTechnologies = "";
    if (filterApplied) {
      strSelectedDomains = filterModel.domains.join(",");
      strSelectedScreens = filterModel.platform.join(",");
      strSelectedTechnologies = filterModel.technologies.join(",");
    }

    final projectDetail = await _dbHelper.getPortfolioWithImage(activeProjectIndex.value,
        domains: strSelectedDomains,
        screens: strSelectedScreens,
        filterApplied: filterApplied,
        projectId: _projectId,
        limit: 1,
        technologies: strSelectedTechnologies);

    if (projectDetail.isNotEmpty) {
      ProjectListModel model = ProjectListModel();
      model.id = projectDetail.first.portfolioId;
      model.projectName = projectDetail.first.portfolioProjectName;
      model.description = projectDetail.first.portfolioProjectDescription;
      model.overView = projectDetail.first.portfolioDomainName;
      model.technologies = projectDetail.first.portfolioScreenTypeName;
      activeProjectIndex.value =
          projectDetail.first.portfolioAutoIncrementId ?? -1;

      projectData.value = model;

      // fetch current portfolio technologies.
      technologies.value =
          await _dbHelper.getPortfolioTechnologies(id: _projectId);

      // fetch current portfolio technologies.
      final projectImages = await _dbHelper.getPortfolioImages(id: _projectId);

      images.value =
          projectImages.map((e) => e.portfolioImagePath ?? "").toList();
    }
  }

  /// Prepare case study data for screen.
  void _prepareCaseStudyData() async {
    String strSelectedDomains = "";
    String strSelectedScreens = "";
    String strSelectedTechnologies = "";
    if (filterApplied) {
      strSelectedDomains = filterModel.domains.join(",");
      strSelectedScreens = filterModel.platform.join(",");
      strSelectedTechnologies = filterModel.technologies.join(",");
    }

    final projectDetail = await _dbHelper.getCaseStudyWithImage(
        activeProjectIndex.value,
        domains: strSelectedDomains,
        filterApplied: filterApplied,
        limit: 1,
        technologies: strSelectedTechnologies);

    if (projectDetail.isNotEmpty) {
      ProjectListModel model = ProjectListModel();
      Get.log(
          "projectDetail.first.caseStudyId ${projectDetail.first.caseStudyId}");
      model.id = projectDetail.first.caseStudyId;
      model.projectName = projectDetail.first.caseStudyProjectName;
      model.description = projectDetail.first.caseStudyProjectDescription;
      model.overView = projectDetail.first.caseStudyDomainName;
      activeProjectIndex.value =
          projectDetail.first.caseStudyAutoIncrementId ?? -1;

      projectData.value = model;

      _projectId = projectData.value.id ?? "";

      // fetch current case study technologies.
      technologies.value =
          await _dbHelper.getCaseStudyTechnologies(id: _projectId);

      // fetch current case study images.
      final projectImages = await _dbHelper.getCaseStudyImages(id: _projectId);

      images.value =
          projectImages.map((e) => e.caseStudyImagePath ?? "").toList();
    }
  }

  /// Change currently visible image index.
  void onSelectImage(int index) {
    activeImageIndex.value = index;
  }

  /// Enable/Disable action buttons.
  void _checkForActionButtons() {
    enableNext.value = activeProjectIndex.value != projectList.length - 1;

    enablePrevious.value = activeProjectIndex.value > 0;
  }

  /// Get data depend on [_portfolioEnum].
  void _getAllData(int pageKey) {
    Future.wait<List<dynamic>>([
      _dbHelper.getPortfolioBySearch(pageKey, search: _searchValue, limit: 1),
      _dbHelper.getCaseStudyBySearch(pageKey, search: _searchValue, limit: 1),
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

          // final isLastPage =
          //     projectList.length < AppConstants.paginationPageLimit;
          //
          // if (isLastPage) {
          //   pagingController.appendLastPage(projectList);
          // } else {
          //   final nextPageKey = pageKey + projectList.length;
          //   pagingController.appendPage(projectList, nextPageKey);
          // }
        } catch (ex) {
          logger.e(ex);
        }
      }
    });
  }
}
enum DetailType{
  listing, filter, search
}