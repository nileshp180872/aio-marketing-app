import 'package:aio/infrastructure/db/database_helper.dart';
import 'package:aio/infrastructure/db/schema/case_study_images.dart';
import 'package:aio/infrastructure/navigation/route_arguments.dart';
import 'package:aio/presentation/filter/model/filter_menu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_constants.dart';
import '../../../config/app_strings.dart';
import '../../../infrastructure/db/schema/portfolio_images.dart';
import '../../../utils/utils.dart';
import '../../project_list/model/project_list_model.dart';

class ProjectDetailController extends GetxController {
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
  RxList<String> listImages = RxList();

  RxString activeImage = "".obs;

  /// Store true if filter is applied otherwise false.
  bool filterApplied = false;

  /// Filter menu model.
  FilterMenu filterModel = FilterMenu();

  final logger = Logger();

  /// Page controller.
  PageController pageController =
      PageController(keepPage: true, initialPage: 0);

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

      Future.delayed(Duration(milliseconds: 10),(){
        if (pageController.hasClients) {
          pageController.animateToPage(activeProjectIndex.value,
              curve: Curves.elasticInOut, duration: const Duration(microseconds: 4));
          _prepareProjectDetails();
        }
      });

    }
  }

  /// Navigate to next page.
  void goToNextPage() {
    if (enableNext.isTrue) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut);
      // activeProjectIndex.value++;
      // _prepareProjectDetails();
    }
  }

  /// Navigate to previous page.
  void goToPreviousPage() {
    if (enablePrevious.isTrue) {
      pageController.previousPage(
          duration: const Duration(milliseconds: 600),
          curve: Curves.linearToEaseOut);
      // activeProjectIndex.value--;
      // _prepareProjectDetails();
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

    if (await Utils.isConnected()) {
      listImages.value = projectData.value.networkImages ?? [];

      technologies.value = projectData.value.technologies ?? "";
    } else {
      if (projectData.value.viewType == AppConstants.portfolio) {
        final portfolio =
            await _dbHelper.getPortfolioDetails(portfolioId: _projectId);
        projectData.value.description =
            portfolio?.portfolioProjectDescription ?? "";
        projectData.value.overView = portfolio?.portfolioDomainName ?? "";
        // fetch current portfolio technologies.
        technologies.value =
            await _dbHelper.getPortfolioTechnologies(id: _projectId);

        // fetch current portfolio technologies.
        List<PortfolioImages> projectImages =
            await _dbHelper.getPortfolioImages(id: _projectId);
        if (projectImages.length > 3) {
          projectImages = projectImages.sublist(0, 3);
        }
        listImages.value =
            projectImages.map((e) => e.portfolioImagePath ?? "").toList();
      } else {
        final portfolio =
            await _dbHelper.getCaseStudyDetails(caseStudyId: _projectId);
        projectData.value.description =
            portfolio?.caseStudyProjectDescription ?? "";
        projectData.value.overView = portfolio?.caseStudyDomainName ?? "";

        // fetch current portfolio technologies.
        technologies.value =
            await _dbHelper.getCaseStudyTechnologies(id: _projectId);

        // fetch current case study images.
        List<CaseStudyImages> projectImages =
            await _dbHelper.getCaseStudyImages(id: _projectId);
        if (projectImages.length > 3) {
          projectImages = projectImages.sublist(0, 3);
        }
        listImages.value =
            projectImages.map((e) => e.caseStudyImagePath ?? "").toList();
      }
    }

    listImages.refresh();

    if (listImages.isNotEmpty) {
      onSelectImage(0);
    }
  }

  /// Change currently visible image index.
  void onSelectImage(int index) {
    activeImage.value = listImages.elementAt(index);
    update();
  }

  /// Enable/Disable action buttons.
  void _checkForActionButtons() {
    enableNext.value = activeProjectIndex.value != projectList.length - 1;

    enablePrevious.value = activeProjectIndex.value > 0;
  }

  /// open URL in device browser.
  void onLinkClick(LinkableElement link) async {
    if (await canLaunchUrl(Uri.parse(link.url))) {
      launchUrl(Uri.parse(link.url));
    } else {
      print("not able to open ${link.url}");
    }
  }

  void onPageChange(int page) {
    activeProjectIndex.value = page;
      _prepareProjectDetails();
  }
}
