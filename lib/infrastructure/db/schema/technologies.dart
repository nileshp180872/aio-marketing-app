import '../db_constants.dart';

class Technologies {
  String? technologyId;
  String? technologyName;

  Technologies({this.technologyId, this.technologyName});

  Technologies.fromJson(Map<String, dynamic> json) {
    technologyId = json[DbConstants.technologicalId];
    technologyName = json[DbConstants.technologicalName];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.technologicalId] = technologyId;
    data[DbConstants.technologicalName] = technologyName;
    return data;
  }
}
