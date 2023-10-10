import 'package:get/get.dart';

import '../model/business_challenge.dart';

class CaseStudyNewController extends GetxController {
  RxList<BusinessChallenge> businessChallenges = RxList();
  RxList<BusinessChallenge> businessSolution = RxList();

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
}
