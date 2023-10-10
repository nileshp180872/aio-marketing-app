import 'package:aio/infrastructure/db/schema/case_study_images.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../config/app_strings.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../utils/utils.dart';
import '../../project_list/model/project_list_model.dart';
import '../model/business_challenge.dart';
import '../provider/case_study_new.provider.dart';

class CaseStudyNewController extends GetxController {
  /// screen title
  RxString screenTitle = AppStrings.domainIndustry.obs;

  /// Project reactive model
  Rx<ProjectListModel> projectData = ProjectListModel().obs;

  late DatabaseHelper _dbHelper;

  late String _projectId;

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
    _initialChallenges();
    _businessSolutions();
    _getTechImage();
    super.onInit();
  }

  /// image Dummy data
  void _getTechImage() {
    techLogo.addAll(["", "", "", "", "", ""]);
  }

  /// Receive arguments from previous screen.
  void _getArguments() {
    if (Get.arguments != null) {
      screenTitle.value = Get.arguments[RouteArguments.screenName] ?? "";

      activeProjectIndex.value = Get.arguments[RouteArguments.index] ?? "";

      projectList.value = Get.arguments[RouteArguments.projectList] ?? [];
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

    if (await Utils.isConnected()) {
      listImages.value = projectData.value.networkImages ?? [];

      technologies.value = projectData.value.technologies ?? "";
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

    listImages.refresh();
  }

  void _initialChallenges() {
    businessChallenges.addAll([
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

  /// Get case studies
  Future<void> _getCaseStudies() async {
    final response = await _provider.getCaseStudy();
    if (response.data != null) {
      if (response.statusCode == 200) {
        _getCaseStudyAPISuccess(response);
      } else {
        _getCaseStudyAPIFailure(response);
      }
    }
  }

  /// Enable/Disable action buttons.
  void _checkForActionButtons() {
    enableNext.value = activeProjectIndex.value != projectList.length - 1;

    enablePrevious.value = activeProjectIndex.value > 0;
  }

  /// Case study API success
  ///
  /// required [response] response.
  void _getCaseStudyAPISuccess(dio.Response response) async {

  }

  /// Case study API Failure
  ///
  /// required [response] response.
  void _getCaseStudyAPIFailure(dio.Response response) async {}
}
