import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

import '../model/business_challenge.dart';
import '../provider/case_study_new.provider.dart';

class CaseStudyNewController extends GetxController {
  RxList<BusinessChallenge> businessChallenges = RxList();
  RxList<BusinessChallenge> businessSolution = RxList();

  final _provider = CaseStudyNewProvider();

  @override
  void onInit() {
    _initialChallenges();
    _businessSolutions();
    super.onInit();
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
