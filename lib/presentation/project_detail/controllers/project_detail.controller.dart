import 'package:aio/infrastructure/db/database_helper.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/presentation/filter/model/filter_menu.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../config/app_constants.dart';
import '../../../config/app_strings.dart';
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

  /// technologies
  RxString technologies = "".obs;

  /// Stores active project index from the list.
  RxInt activeProjectIndex = 0.obs;

  /// Store true if next item available from the list.
  RxBool enableNext = false.obs;

  /// Shoes previous project available from the list.
  RxBool enablePrevious = false.obs;

  /// Project images
  RxList<String> images = RxList();

  RxList<String> listImages = RxList();

  RxString activeImage = "".obs;

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

      activeProjectIndex.value = Get.arguments[RouteArguments.index] ?? "";

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
    _preparePortfolioData();
    _checkForActionButtons();
  }

  /// Prepare portfolio data for screen.
  void _preparePortfolioData() async {
    projectData.value = projectList[activeProjectIndex.value];

    _projectId = projectData.value.id ?? "";

    screenTitle.value = projectData.value.projectName ?? "";

    if (projectData.value.viewType == AppConstants.portfolio) {
      final portfolio = await _dbHelper.getPortfolioDetails(portfolioId: _projectId);
      projectData.value.description = portfolio?.portfolioProjectDescription??"";
      projectData.value.overView = portfolio?.portfolioDomainName??"";
      // fetch current portfolio technologies.
      technologies.value =
          await _dbHelper.getPortfolioTechnologies(id: _projectId);

      // fetch current portfolio technologies.
      final projectImages = await _dbHelper.getPortfolioImages(id: _projectId);

      Get.log("projectImages ${projectImages.length}");
      images.value =
          projectImages.map((e) => e.portfolioImagePath ?? "").toList();
    } else {
      final portfolio = await _dbHelper.getCaseStudyDetails(caseStudyId: _projectId);
      projectData.value.description = portfolio?.caseStudyProjectDescription??"";
      projectData.value.overView = portfolio?.caseStudyDomainName??"";


      // fetch current portfolio technologies.
      technologies.value =
          await _dbHelper.getCaseStudyTechnologies(id: _projectId);

      // fetch current case study images.
      final projectImages = await _dbHelper.getCaseStudyImages(id: _projectId);

      images.value =
          projectImages.map((e) => e.caseStudyImagePath ?? "").toList();
    }

    images.value.forEach((element) {
      Get.log("emages ${element}");
    });

    activeImage.value = images.isNotEmpty?images.first:"";
    if (images.length > 1) {
      listImages = images..removeAt(0);
    } else {
      listImages = images;
    }
    listImages.refresh();
  }

  /// Change currently visible image index.
  void onSelectImage(int index) {
    var imageData = activeImage.value;
    activeImage.value = listImages.elementAt(index);
    listImages.remove(listImages[index]);
    listImages.add(imageData);
    listImages.refresh();
    update();
  }

  /// Enable/Disable action buttons.
  void _checkForActionButtons() {
    enableNext.value = activeProjectIndex.value != projectList.length - 1;

    enablePrevious.value = activeProjectIndex.value > 0;
  }
}
