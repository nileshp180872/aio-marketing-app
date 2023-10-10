import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../project_list/model/project_list_model.dart';
import '../model/business_challenge.dart';
import '../provider/case_study_new.provider.dart';

class CaseStudyNewController extends GetxController {
  RxList<BusinessChallenge> businessChallenges = RxList();
  RxList<BusinessChallenge> businessSolution = RxList();
  RxList<String> businessImages = RxList();

  final logger = Logger();

  final _provider = CaseStudyNewProvider();

  /// Project list
  RxList<ProjectListModel> projectList = RxList();

  @override
  void onInit() {
    _getArguments();
    _initialChallenges();
    _businessSolutions();
    super.onInit();
  }


  /// Receive arguments from previous screen.
  void _getArguments() {
    businessImages.addAll([
      "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fsample&psig=AOvVaw0_F4rVaD4dGQt_gl31y4fm&ust=1697022376154000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCOi8iZKr64EDFQAAAAAdAAAAABAJ",
      "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fsample&psig=AOvVaw0_F4rVaD4dGQt_gl31y4fm&ust=1697022376154000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCOi8iZKr64EDFQAAAAAdAAAAABAJ",
      "https://www.google.com/url?sa=i&url=https%3A%2F%2Funsplash.com%2Fs%2Fphotos%2Fsample&psig=AOvVaw0_F4rVaD4dGQt_gl31y4fm&ust=1697022376154000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCOi8iZKr64EDFQAAAAAdAAAAABAJ",
    ]);
    if (Get.arguments != null) {
      // screenTitle.value = Get.arguments[RouteArguments.screenName] ?? "";
      //
      // activeProjectIndex.value = Get.arguments[RouteArguments.index] ?? "";
      //
      // projectList.value = Get.arguments[RouteArguments.projectList] ?? [];
      //
      // _portfolioEnum = Get.arguments[RouteArguments.portfolioEnum] ??
      //     PortfolioEnum.PORTFOLIO;
      //
      // _prepareProjectDetails();
    }
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

  /// Case study API success
  ///
  /// required [response] response.
  void _getCaseStudyAPISuccess(dio.Response response) async {}

  /// Case study API Failure
  ///
  /// required [response] response.
  void _getCaseStudyAPIFailure(dio.Response response) async {}
}
