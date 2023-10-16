import '../db_constants.dart';

class CaseStudyTechImages {
  String? caseStudyTechImageId;
  String? caseStudyTechImagePath;
  String? caseStudyTechImagePortfolioId;

  CaseStudyTechImages(
      {this.caseStudyTechImageId,
      this.caseStudyTechImagePath,
      this.caseStudyTechImagePortfolioId});

  CaseStudyTechImages.fromJson(Map<String, dynamic> json) {
    caseStudyTechImageId = json[DbConstants.caseStudyTechImageId];
    caseStudyTechImagePath = json[DbConstants.caseStudyTechImageName];
    caseStudyTechImagePortfolioId =
        json[DbConstants.caseStudyTechMapCaseStudyTableId];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.caseStudyTechImageId] = caseStudyTechImageId;
    data[DbConstants.caseStudyTechImageName] = caseStudyTechImagePath;
    data[DbConstants.caseStudyTechMapCaseStudyTableId] = caseStudyTechImagePortfolioId;
    return data;
  }
}
