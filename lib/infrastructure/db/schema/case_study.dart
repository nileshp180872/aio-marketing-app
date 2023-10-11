import 'dart:convert';

import '../db_constants.dart';

class CaseStudy {
  int? caseStudyAutoIncrementId;
  String? caseStudyId;
  String? caseStudyDomainId;
  String? caseStudyDomainName;
  String? caseStudyProjectName;
  String? caseStudyProjectDescription;
  String? caseStudyBusinessTitle1;
  String? caseStudyBusinessTitle2;
  String? caseStudyBusinessTitle3;
  String? caseStudyBusinessDescription1;
  String? caseStudyBusinessDescription2;
  String? caseStudyBusinessDescription3;
  String? caseStudyBusinessImage1;
  String? caseStudyBusinessImage2;
  String? caseStudyBusinessImage3;
  String? caseStudyCompanyId;
  String? caseStudyCompanyTitle;
  String? caseStudyCompanyImage;
  String? caseStudyCompanyDescription;
  String? caseStudySolutionTitle1;
  String? caseStudySolutionTitle2;
  String? caseStudySolutionTitle3;
  String? caseStudySolutionDescription1;
  String? caseStudySolutionDescription2;
  String? caseStudySolutionDescription3;
  String? caseStudySolutionImage1;
  String? caseStudySolutionImage3;
  String? caseStudySolutionImage2;
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
      this.caseStudyBusinessTitle1,
      this.caseStudyBusinessTitle2,
      this.caseStudyBusinessTitle3,
      this.caseStudyBusinessDescription1,
      this.caseStudyBusinessDescription2,
      this.caseStudyBusinessDescription3,
      this.caseStudyBusinessImage1,
      this.caseStudyBusinessImage2,
      this.caseStudyBusinessImage3,
      this.caseStudyCompanyId,
      this.caseStudyCompanyTitle,
      this.caseStudyCompanyImage,
      this.caseStudyCompanyDescription,
      this.caseStudySolutionTitle1,
      this.caseStudySolutionTitle2,
      this.caseStudySolutionTitle3,
      this.caseStudySolutionDescription1,
      this.caseStudySolutionDescription2,
      this.caseStudySolutionDescription3,
      this.caseStudySolutionImage1,
      this.caseStudySolutionImage2,
      this.caseStudySolutionImage3,
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
    caseStudyBusinessTitle1 = json[DbConstants.caseStudyBusinessTitle1];
    caseStudyBusinessTitle2 = json[DbConstants.caseStudyBusinessTitle2];
    caseStudyBusinessTitle3= json[DbConstants.caseStudyBusinessTitle3];
    caseStudyBusinessDescription1= json[DbConstants.caseStudyBusinessDescription1];
    caseStudyBusinessDescription2= json[DbConstants.caseStudyBusinessDescription2];
    caseStudyBusinessDescription3= json[DbConstants.caseStudyBusinessDescription3];
    caseStudyBusinessImage1= json[DbConstants.caseStudyBusinessImage1];
    caseStudyBusinessImage2= json[DbConstants.caseStudyBusinessImage2];
    caseStudyBusinessImage3= json[DbConstants.caseStudyBusinessImage3];
    caseStudyCompanyId= json[DbConstants.caseStudyCompanyId];
    caseStudyCompanyTitle= json[DbConstants.caseStudyCompanyTitle];
    caseStudyCompanyImage= json[DbConstants.caseStudyCompanyImage];
    caseStudyCompanyDescription= json[DbConstants.caseStudyCompanyDescription];
    caseStudySolutionTitle1= json[DbConstants.caseStudySolutionTitle1];
    caseStudySolutionTitle2= json[DbConstants.caseStudySolutionTitle2];
    caseStudySolutionTitle3= json[DbConstants.caseStudySolutionTitle3];
    caseStudySolutionDescription1= json[DbConstants.caseStudySolutionDescription1];
    caseStudySolutionDescription2= json[DbConstants.caseStudySolutionDescription2];
    caseStudySolutionDescription3= json[DbConstants.caseStudySolutionDescription3];
    caseStudySolutionImage1= json[DbConstants.caseStudySolutionImage1];
    caseStudySolutionImage2= json[DbConstants.caseStudySolutionImage2];
    caseStudySolutionImage3= json[DbConstants.caseStudySolutionImage3];
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
    data[DbConstants.caseStudyBusinessTitle1] = caseStudyBusinessTitle1;
    data[DbConstants.caseStudyBusinessTitle2] = caseStudyBusinessTitle2;
    data[DbConstants.caseStudyBusinessTitle3] = caseStudyBusinessTitle3;
    data[DbConstants.caseStudyBusinessDescription1] = caseStudyBusinessDescription1;
    data[DbConstants.caseStudyBusinessDescription2] = caseStudyBusinessDescription2;
    data[DbConstants.caseStudyBusinessDescription3] = caseStudyBusinessDescription3;
    data[DbConstants.caseStudyBusinessImage1] = caseStudyBusinessImage1;
    data[DbConstants.caseStudyBusinessImage2] = caseStudyBusinessImage2;
    data[DbConstants.caseStudyBusinessImage3] = caseStudyBusinessImage3;
    data[DbConstants.caseStudyCompanyId] = caseStudyCompanyId;
    data[DbConstants.caseStudyCompanyTitle] = caseStudyCompanyTitle;
    data[DbConstants.caseStudyCompanyImage] = caseStudyCompanyImage;
    data[DbConstants.caseStudyCompanyDescription] = caseStudyCompanyDescription;
    data[DbConstants.caseStudySolutionTitle1] = caseStudySolutionTitle1;
    data[DbConstants.caseStudySolutionTitle2] = caseStudySolutionTitle2;
    data[DbConstants.caseStudySolutionTitle3] = caseStudySolutionTitle3;
    data[DbConstants.caseStudySolutionDescription1] = caseStudySolutionDescription1;
    data[DbConstants.caseStudySolutionDescription2] = caseStudySolutionDescription2;
    data[DbConstants.caseStudySolutionDescription3] = caseStudySolutionDescription3;
    data[DbConstants.caseStudySolutionImage1] = caseStudySolutionImage1;
    data[DbConstants.caseStudySolutionImage2] = caseStudySolutionImage2;
    data[DbConstants.caseStudySolutionImage3] = caseStudySolutionImage3;
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
