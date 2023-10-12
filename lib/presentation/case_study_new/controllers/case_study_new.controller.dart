import 'package:aio/infrastructure/db/schema/case_study_images.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/case_study_tech_image.dart';
import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../utils/utils.dart';
import '../../project_list/model/project_list_model.dart';
import '../model/business_challenge.dart';
import '../provider/case_study_new.provider.dart';
import '../view/share_doc_dialog.dart';

class CaseStudyNewController extends GetxController {
  /// screen title
  RxString screenTitle = AppStrings.domainIndustry.obs;

  /// Project reactive model
  Rx<ProjectListModel> projectData = ProjectListModel().obs;

  ScrollController scrollController = ScrollController();
  late DatabaseHelper _dbHelper;

  late String _projectId;

  /// Page controller.
  PageController pageController =
      PageController(keepPage: true, initialPage: 0);

  /// technologies
  RxString technologies = "".obs;

  RxList<BusinessChallenge> businessChallenges = RxList();
  RxList<BusinessChallenge> businessSolution = RxList();
  RxList<String> businessImages = RxList();
  RxList<String> techLogo = RxList();
  RxList<String> lstPlatform = RxList();
  RxList<String> lstDomain = RxList();

  /// Project images
  RxList<String> listImages = RxList();

  final logger = Logger();

  final _provider = CaseStudyNewProvider();

  /// Stores active project index from the list.
  RxInt activeProjectIndex = 0.obs;

  /// Store true if next item available from the list.
  RxBool enableNext = false.obs;

  /// Shoes previous project available from the list.
  RxBool enablePrevious = false.obs;

  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  @override
  void onInit() {
    _getArguments();
    super.onInit();

    pageController.addListener(() {
      activeProjectIndex.value = pageController.page!.round();
      Future.delayed(const Duration(milliseconds: 400),(){
        _prepareProjectDetails();
      });
    });
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
      activeProjectIndex.value++;
      _prepareProjectDetails();
      _scrollToTop();
    }
  }

  /// Navigate to previous page.
  void goToPreviousPage() {
    if (enablePrevious.isTrue) {
      activeProjectIndex.value--;
      _prepareProjectDetails();
      _scrollToTop();
    }
  }

  /// Get project detail by id.
  void _prepareProjectDetails() async {
    _preparePortfolioData();
    _checkForActionButtons();
  }

  /// Prepare portfolio data for screen.
  void _preparePortfolioData() async {
    businessChallenges.clear();
    projectData.value = projectList[activeProjectIndex.value];

    _projectId = projectData.value.id ?? "";

    screenTitle.value = projectData.value.projectName ?? "";

    if (await Utils.isConnected()) {
      businessImages.value = projectData.value.sliderImages ?? [];
      businessImages.value.removeWhere((element) => element.isEmpty);
      technologies.value = projectData.value.technologies ?? "";
      businessChallenges.clear();
      businessSolution.clear();
      businessChallenges.addAll([
        BusinessChallenge(
            description: projectData.value.businessDescription1,
            icon: projectData.value.businessImage1,
            title: projectData.value.businessTitle1),
        BusinessChallenge(
            description: projectData.value.businessDescription2,
            icon: projectData.value.businessImage2,
            title: projectData.value.businessTitle2),
        BusinessChallenge(
            description: projectData.value.businessDescription3,
            icon: projectData.value.businessImage3,
            title: projectData.value.businessTitle3),
      ]);
      Get.log(
          "projectData.value.solutionTitle1 ${projectData.value.solutionTitle1}");
      businessSolution.addAll([
        BusinessChallenge(
            description: projectData.value.solutionDescription1,
            icon: projectData.value.solutionImage1,
            title: projectData.value.solutionTitle1),
        BusinessChallenge(
            description: projectData.value.solutionDescription2,
            icon: projectData.value.solutionImage2,
            title: projectData.value.solutionTitle2),
        BusinessChallenge(
            description: projectData.value.solutionDescription3,
            icon: projectData.value.solutionImage3,
            title: projectData.value.solutionTitle3),
      ]);

      techLogo.value = projectData.value.techMapping ?? [];
      listImages.value = projectData.value.sliderImages ?? [];

      await Future.delayed(Duration(seconds: 2), () {
        projectData.refresh();
        businessSolution.refresh();
      });
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
      List<CaseStudyTechImages> projectTechnologyImages =
          await _dbHelper.getCaseStudyMapImages(id: _projectId);

      techLogo.value = projectTechnologyImages
          .map((e) => e.caseStudyTechImagePath ?? "")
          .toList();

      // fetch current case study images.
      List<CaseStudyImages> projectImages =
          await _dbHelper.getCaseStudyImages(id: _projectId);
      if (projectImages.length > 3) {
        projectImages = projectImages.sublist(0, 3);
      }
      listImages.value =
          projectImages.map((e) => e.caseStudyImagePath ?? "").toList();
    }

    listImages.refresh();
  }

  /// Business solutions
  void _businessSolutions() {
    businessSolution.addAll([
      BusinessChallenge(
          title: "Changing technologies and customer expectation",
          description:
              "Businesses must constantly adapt to new technologies and trends if they want to keep up with constantly evolving technology. It should also ensure that its platforms are accessible, flexible, and scalable as per customers’ expectations.",
          icon: ""),
      BusinessChallenge(
          title: "Ensuring security and managing data",
          description:
              "As sensitive data is increasingly stored and transmitted online, security has become a major concern for tech companies. Managing and analyzing the growing volume of data presents additional challenges.",
          icon: ""),
      BusinessChallenge(
          title: "Changing technologies and customer expectation",
          description:
              "Businesses must constantly adapt to new technologies and trends if they want to keep up with constantly evolving technology. It should also ensure that its platforms are accessible, flexible, and scalable as per customers’ expectations.",
          icon: "")
    ]);
  }

  /// Enable/Disable action buttons.
  void _checkForActionButtons() {
    enableNext.value = activeProjectIndex.value != projectList.length - 1;

    enablePrevious.value = activeProjectIndex.value > 0;
  }

  /// Case study API success
  ///
  /// required [response] response.
  void _getCaseStudyAPISuccess(dio.Response response) async {}

  void showSuccessDialog() {
    Utils.showSuccessDialog(
        navigateToHome: false, message: AppStrings.shareCaseStudySuccess);
  }

  /// Case study API Failure
  ///
  /// required [response] response.
  void _getCaseStudyAPIFailure(dio.Response response) async {}

  void openDialog() {}

  void openGmail() async {
    Get.dialog(Material(
        color: Colors.transparent,
        child: ShareDocDialog(
          onShareClick: (value) => shareCasestuduDetail(value, _projectId),
          onSuccess: showSuccessDialog,
        )));
  }

  /// Get case studies
  Future<bool> shareCasestuduDetail(String email, String id) async {
    final response = await _provider.sendLinkInvitation(email, id);
    if (response.data != null) {
      if (response.statusCode == 200) {
        _getCaseStudyAPISuccess(response);
        return true;
      } else {
        _getCaseStudyAPIFailure(response);
        return false;
      }
    } else {
      return false;
    }
  }

  /// Scroll to top of the screen.
  void _scrollToTop() {
    scrollController.animateTo(scrollController.position.minScrollExtent,
        duration: const Duration(milliseconds: 500), curve: Curves.ease);
  }

  void onPageChange(int page) {
    activeProjectIndex.value = page;
    _prepareProjectDetails();
  }
}
