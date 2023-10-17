import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
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
  PageController pageController = PageController(initialPage: 0);

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
    _dbHelper = GetIt.I<DatabaseHelper>();
    _getArguments();
    super.onInit();

    pageController.addListener(() {
      activeProjectIndex.value = pageController.page!.round();
      Future.delayed(const Duration(milliseconds: 400), () {
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

      Future.delayed(const Duration(milliseconds: 10), () {
        if (pageController.hasClients) {
          pageController.animateToPage(activeProjectIndex.value,
              curve: Curves.elasticInOut,
              duration: const Duration(microseconds: 4));
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
      techLogo.value = projectData.value.techMapping ?? [];
      listImages.value = projectData.value.sliderImages ?? [];
      await Future.delayed(const Duration(milliseconds: 600), () {
        projectData.refresh();
      });
    }
    listImages.refresh();
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

  void openGmail() async {
    if (await Utils.isConnected()) {
      Get.dialog(Material(
          color: Colors.transparent,
          child: ShareDocDialog(
            onShareClick: (value) => shareCasestuduDetail(value, _projectId),
            onSuccess: showSuccessDialog,
          )));
    } else {
      Utils.showErrorMessage(message: AppStrings.offlineShareMessage);
    }
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
