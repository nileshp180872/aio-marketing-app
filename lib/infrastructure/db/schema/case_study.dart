import 'dart:convert';

import '../db_constants.dart';

class CaseStudy {
  int? caseStudyAutoIncrementId;
  String? caseStudyId;
  String? caseStudyDomainId;
  String? caseStudyDomainName;
  String? caseStudyProjectName;
  String? caseStudyProjectDescription;
  String? caseStudyBusinessTitle;
  String? caseStudyBusinessDescription;
  String? caseStudyBusinessImage;
  String? caseStudyCompanyId;
  String? caseStudyCompanyTitle;
  String? caseStudyCompanyImage;
  String? caseStudyCompanyDescription;
  String? caseStudySolutionTitle;
  String? caseStudySolutionDescription;
  String? caseStudySolutionImage;
  String? caseStudyLink;
  String? caseStudyDocument;
  String? images;
  List<String>? caseStudyProjectImages;

  CaseStudy(
      {this.caseStudyAutoIncrementId,
      this.caseStudyId,
      this.caseStudyDomainId,
      this.caseStudyDomainName,
      this.caseStudyProjectImages,
      this.caseStudyProjectName,
      this.caseStudyBusinessTitle,
      this.caseStudyBusinessDescription,
      this.caseStudyBusinessImage,
      this.caseStudyCompanyId,
      this.caseStudyCompanyTitle,
      this.caseStudyCompanyImage,
      this.caseStudyCompanyDescription,
      this.caseStudySolutionTitle,
      this.caseStudySolutionDescription,
      this.caseStudySolutionImage,
      this.caseStudyLink,
      this.caseStudyDocument,
      this.images,
      this.caseStudyProjectDescription});

  CaseStudy.fromJson(Map<String, dynamic> json) {
    caseStudyAutoIncrementId = json[DbConstants.caseStudyAIId];
    caseStudyId = json[DbConstants.caseStudyId];
    caseStudyDomainId = json[DbConstants.caseStudyDomainId];
    caseStudyDomainName = json[DbConstants.caseStudyDomainName];
    caseStudyProjectName = json[DbConstants.caseStudyProjectName];
    caseStudyProjectDescription = json[DbConstants.caseStudyDescription];
    caseStudyBusinessTitle = json[DbConstants.caseStudyBusinessTitle];
    caseStudyBusinessDescription= json[DbConstants.caseStudyBusinessDescription];
    caseStudyBusinessImage= json[DbConstants.caseStudyBusinessImage];
    caseStudyCompanyId= json[DbConstants.caseStudyCompanyId];
    caseStudyCompanyTitle= json[DbConstants.caseStudyCompanyTitle];
    caseStudyCompanyImage= json[DbConstants.caseStudyCompanyImage];
    caseStudyCompanyDescription= json[DbConstants.caseStudyCompanyDescription];
    caseStudySolutionTitle= json[DbConstants.caseStudySolutionTitle];
    caseStudySolutionDescription= json[DbConstants.caseStudySolutionDescription];
    caseStudySolutionImage= json[DbConstants.caseStudySolutionImage];
    caseStudyLink= json[DbConstants.caseStudyLink];
    caseStudyDocument= json[DbConstants.caseStudyDocuments];
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
    data[DbConstants.caseStudyBusinessTitle] = caseStudyBusinessTitle;
    data[DbConstants.caseStudyBusinessDescription] = caseStudyBusinessDescription;
    data[DbConstants.caseStudyBusinessImage] = caseStudyBusinessImage;
    data[DbConstants.caseStudyCompanyId] = caseStudyCompanyId;
    data[DbConstants.caseStudyCompanyTitle] = caseStudyCompanyTitle;
    data[DbConstants.caseStudyCompanyImage] = caseStudyCompanyImage;
    data[DbConstants.caseStudyCompanyDescription] = caseStudyCompanyDescription;
    data[DbConstants.caseStudySolutionTitle] = caseStudySolutionTitle;
    data[DbConstants.caseStudySolutionDescription] = caseStudySolutionDescription;
    data[DbConstants.caseStudySolutionImage] = caseStudySolutionImage;
    data[DbConstants.caseStudyLink] = caseStudyLink;
    data[DbConstants.caseStudyDocuments] = caseStudyDocument;
    if (caseStudyProjectImages != null) {
      var json =
          jsonEncode(caseStudyProjectImages, toEncodable: (e) => e!.toString());

      data[DbConstants.caseStudyImages] = json;
    }
    return data;
  }
}
