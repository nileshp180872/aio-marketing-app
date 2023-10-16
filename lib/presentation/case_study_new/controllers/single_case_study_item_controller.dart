import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/case_study_images.dart';
import '../../../infrastructure/db/schema/case_study_tech_image.dart';
import '../../../utils/utils.dart';
import '../../project_list/model/project_list_model.dart';
import '../model/business_challenge.dart';

class SingleCaseStudyItemController extends GetxController{


  /// Project reactive model
  Rx<ProjectListModel> projectData = ProjectListModel().obs;

  ScrollController scrollController = ScrollController();

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

  late DatabaseHelper _dbHelper;
  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();
    super.onInit();
  }

  /// Prepare portfolio data for screen.
  void preparePortfolioData() async {
    businessChallenges.clear();

    _projectId = projectData.value.id ?? "";


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
      projectData.value.companyDescription = portfolio?.caseStudyCompanyDescription ?? "";
      projectData.value.solutionImage1 = portfolio?.caseStudySolutionImage1 ?? "";
      projectData.value.solutionImage2 = portfolio?.caseStudySolutionImage2 ?? "";
      projectData.value.solutionImage3 = portfolio?.caseStudySolutionImage3 ?? "";
      projectData.value.solutionTitle1 = portfolio?.caseStudySolutionTitle1 ?? "";
      projectData.value.solutionTitle2 = portfolio?.caseStudySolutionTitle2 ?? "";
      projectData.value.solutionTitle3 = portfolio?.caseStudySolutionTitle3 ?? "";
      projectData.value.solutionDescription1 = portfolio?.caseStudySolutionDescription1 ?? "";
      projectData.value.solutionDescription2 = portfolio?.caseStudySolutionDescription2 ?? "";
      projectData.value.solutionDescription3 = portfolio?.caseStudySolutionDescription3 ?? "";
      projectData.value.businessImage1 = portfolio?.caseStudyBusinessImage1 ?? "";
      projectData.value.businessImage2 = portfolio?.caseStudyBusinessImage2 ?? "";
      projectData.value.businessImage3 = portfolio?.caseStudyBusinessImage3 ?? "";
      projectData.value.businessTitle1 = portfolio?.caseStudyBusinessTitle1 ?? "";
      projectData.value.businessTitle2 = portfolio?.caseStudyBusinessTitle2 ?? "";
      projectData.value.businessTitle3 = portfolio?.caseStudyBusinessTitle3 ?? "";
      projectData.value.businessDescription1 = portfolio?.caseStudyBusinessDescription1 ?? "";
      projectData.value.businessDescription2 = portfolio?.caseStudyBusinessDescription2 ?? "";
      projectData.value.businessDescription3 = portfolio?.caseStudyBusinessDescription3 ?? "";
      projectData.value.conclusion = portfolio?.caseStudyConclusion ?? "";
      projectData.value.domainName = portfolio?.caseStudyDomainName ?? "";
      projectData.value.casestudyBannerImage = portfolio?.caseStudyBannerImage ?? "";
      projectData.value.casestudyThumbnailImage = portfolio?.caseStudyThumbnailImage ?? "";

      // fetch current portfolio technologies.
      technologies.value =
      await _dbHelper.getCaseStudyTechnologies(id: _projectId);

      projectData.value.technologies = technologies.value;
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
    businessChallenges.clear();
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
    Get.log("businessChallenges ${businessChallenges.length}");
    listImages.refresh();
  }
}