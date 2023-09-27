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

  /// technologies
  RxString technologies = "".obs;

  RxInt activeImageIndex = 0.obs;

  RxInt activeProjectIndex = 0.obs;

  // Project images
  RxList<String> images = RxList();

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

      projectList.value = Get.arguments[RouteArguments.projectList] ?? [];

      _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
          PortfolioEnum.PORTFOLIO;

      _projectListTypeEnum = Get.arguments[RouteArguments.projectListType] ??
          ProjectListTypeEnum.DOMAIN;

      _prepareProjectDetails();
    }
  }

  /// Navigate to next page.
  void goToNextPage() {
    if (activeImageIndex.value != projectList.length - 1) {
      activeImageIndex.value++;
      _prepareProjectDetails();
    }
  }

  /// Navigate to previous page.
  void goToPreviousPage() {
    if (activeImageIndex.value > 0) {
      activeImageIndex.value--;
      _prepareProjectDetails();
    }
  }

  /// Get project detail by id.
  void _prepareProjectDetails() async {
    if (_portfolioEnum == PortfolioEnum.PORTFOLIO) {
      _preparePortfolioData();
    } else {
      _prepareCaseStudyData();
    }
  }

  /// Prepare portfolio data for screen.
  void _preparePortfolioData() async {
    projectData.value = projectList[activeProjectIndex.value];

    _projectId = projectData.value.id ?? "";

    // fetch current portfolio technologies.
    technologies.value =
        await _dbHelper.getPortfolioTechnologies(id: _projectId);

    // fetch current portfolio technologies.
    final projectImages = await _dbHelper.getPortfolioImages(id: _projectId);

    images.value =
        projectImages.map((e) => e.portfolioImagePath ?? "").toList();
  }

  /// Prepare case study data for screen.
  void _prepareCaseStudyData() async {
    projectData.value = projectList[activeProjectIndex.value];

    screenTitle.value = projectData.value.projectName ?? "";

    _projectId = projectData.value.id ?? "";

    // fetch current case study technologies.
    technologies.value =
        await _dbHelper.getCaseStudyTechnologies(id: _projectId);

    // fetch current case study images.
    final projectImages = await _dbHelper.getCaseStudyImages(id: _projectId);

    images.value =
        projectImages.map((e) => e.caseStudyImagePath ?? "").toList();
  }

  /// Change currently visible image index.
  void onSelectImage(int index) {
    activeImageIndex.value = index;
  }
}
