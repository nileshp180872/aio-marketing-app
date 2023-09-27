import '../db_constants.dart';

class CaseStudyImages {
  String? caseStudyImageId;
  String? caseStudyImagePath;
  String? caseStudyImagePortfolioId;

  CaseStudyImages(
      {this.caseStudyImageId,
      this.caseStudyImagePath,
      this.caseStudyImagePortfolioId});

  CaseStudyImages.fromJson(Map<String, dynamic> json) {
    caseStudyImageId = json[DbConstants.caseStudyImageId];
    caseStudyImagePath = json[DbConstants.caseStudyImagePath];
    caseStudyImagePortfolioId = json[DbConstants.caseStudyImageCaseStudyId];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.caseStudyImageId] = caseStudyImageId;
    data[DbConstants.caseStudyImagePath] = caseStudyImagePath;
    data[DbConstants.caseStudyImageCaseStudyId] = caseStudyImagePortfolioId;
    return data;
  }
}
