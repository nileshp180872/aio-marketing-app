import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/app_constants.dart';
import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/case_study_images.dart';
import '../../../infrastructure/db/schema/portfolio_images.dart';
import '../../../utils/utils.dart';
import '../../project_list/model/project_list_model.dart';

class ProjectItemController extends GetxController {
  /// Project reactive model
  Rx<ProjectListModel> projectData = ProjectListModel().obs;

  late DatabaseHelper _dbHelper;

  String projectId = "";

  RxInt activeImageIndex = 0.obs;

  @override
  void onInit() {
    _dbHelper = GetIt.I<DatabaseHelper>();
  }

  /// Project images
  RxList<String> listImages = RxList();

  RxString activeImage = "".obs;

  /// technologies
  RxString technologies = "".obs;

  /// Change currently visible image index.
  void onSelectImage(int index) {
    activeImageIndex.value = index;
    Future.delayed(const Duration(milliseconds: 100), () {
      activeImageIndex.refresh();
    });
  }

  /// open URL in device browser.
  void onLinkClick(LinkableElement link) async {
    if (await canLaunchUrl(Uri.parse(link.url))) {
      launchUrl(Uri.parse(link.url));
    } else {
      print("not able to open ${link.url}");
    }
  }

  /// Prepare portfolio data for screen.
  void preparePortfolioData() async {
    if (await Utils.isConnected()) {
      projectId = projectData.value.id ?? "";
      listImages.value = projectData.value.networkImages ?? [];

      technologies.value = projectData.value.technologies ?? "";
    } else {
      if (projectData.value.viewType == AppConstants.portfolio) {
        technologies.value =
            await _dbHelper.getPortfolioTechnologies(id: projectId);

        // fetch current portfolio technologies.
        List<PortfolioImages> projectImages =
            await _dbHelper.getPortfolioImages(id: projectId);
        if (projectImages.length > 3) {
          projectImages = projectImages.sublist(0, 3);
        }

        if (listImages.isNotEmpty) {
          onSelectImage(0);
        }
      } else {
        final portfolio =
            await _dbHelper.getCaseStudyDetails(caseStudyId: projectId);
        projectData.value.description =
            portfolio?.caseStudyProjectDescription ?? "";
        projectData.value.overView = portfolio?.caseStudyDomainName ?? "";

        // fetch current portfolio technologies.
        technologies.value =
            await _dbHelper.getCaseStudyTechnologies(id: projectId);

        // fetch current case study images.
        List<CaseStudyImages> projectImages =
            await _dbHelper.getCaseStudyImages(id: projectId);
        if (projectImages.length > 3) {
          projectImages = projectImages.sublist(0, 3);
        }
        listImages.value =
            projectImages.map((e) => e.caseStudyImagePath ?? "").toList();
      }
    }

    listImages.refresh();

    projectData.refresh();
  }
}
