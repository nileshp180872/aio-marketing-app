import '../db_constants.dart';

class Platform {
  String? platformId;
  String? platformName;

  Platform({this.platformId, this.platformName});

  Platform.fromJson(Map<String, dynamic> json) {
    platformId = json[DbConstants.platformId];
    platformName = json[DbConstants.platformName];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.platformId] = platformId;
    data[DbConstants.platformName] = platformName;
    return data;
  }
}
