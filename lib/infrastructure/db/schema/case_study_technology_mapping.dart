import '../db_constants.dart';

class CaseStudyTechnologyMapping {
  String? caseStudyTechnologyId;
  String? caseStudyTechnologyName;
  String? caseStudyTableId;

  CaseStudyTechnologyMapping(
      {this.caseStudyTechnologyId,
      this.caseStudyTechnologyName,
      this.caseStudyTableId});

  CaseStudyTechnologyMapping.fromJson(Map<String, dynamic> json) {
    caseStudyTechnologyId = json[DbConstants.caseStudyTechnologyId];
    caseStudyTechnologyName = json[DbConstants.caseStudyTechnologyName];
    caseStudyTableId = json[DbConstants.caseStudyTableId];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.caseStudyTableId] = caseStudyTableId;
    data[DbConstants.caseStudyTechnologyName] = caseStudyTechnologyName;
    data[DbConstants.caseStudyTechnologyId] = caseStudyTechnologyId;
    return data;
  }
}
