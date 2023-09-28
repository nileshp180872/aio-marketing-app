import 'dart:convert';

import '../db_constants.dart';

class CaseStudy {
  int? caseStudyAutoIncrementId;
  String? caseStudyId;
  String? caseStudyDomainId;
  String? caseStudyDomainName;
  String? caseStudyProjectName;
  String? caseStudyProjectDescription;
  String? images;
  List<String>? caseStudyProjectImages;

  CaseStudy(
      {this.caseStudyAutoIncrementId,this.caseStudyId,
      this.caseStudyDomainId,
      this.caseStudyDomainName,
      this.caseStudyProjectImages,
      this.caseStudyProjectName,
        this.images,
      this.caseStudyProjectDescription});

  CaseStudy.fromJson(Map<String, dynamic> json) {
    caseStudyAutoIncrementId = json[DbConstants.caseStudyAIId];
    caseStudyId = json[DbConstants.caseStudyId];
    caseStudyDomainId = json[DbConstants.caseStudyDomainId];
    caseStudyDomainName = json[DbConstants.caseStudyDomainName];
    caseStudyProjectName = json[DbConstants.caseStudyProjectName];
    caseStudyProjectDescription = json[DbConstants.caseStudyDescription];
    images = json[DbConstants.images];
    if (json[DbConstants.projectImages] != null) {
      caseStudyProjectImages = <String>[];
      (json[DbConstants.projectImages].split(" ")).forEach((v) {
        caseStudyProjectImages!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.caseStudyAIId] = caseStudyAutoIncrementId;
    data[DbConstants.caseStudyId] = caseStudyId;
    data[DbConstants.caseStudyDomainId] = caseStudyDomainId;
    data[DbConstants.caseStudyDomainName] = caseStudyDomainName;
    data[DbConstants.caseStudyProjectName] = caseStudyProjectName;
    data[DbConstants.caseStudyDescription] = caseStudyProjectDescription;
    if (caseStudyProjectImages != null) {
      var json =
          jsonEncode(caseStudyProjectImages, toEncodable: (e) => e!.toString());

      data[DbConstants.caseStudyImages] = json;
    }
    return data;
  }
}
