import '../db_constants.dart';

class LeadershipType {
  String? leadershipTypeId;
  String? leadershipTypeName;

  LeadershipType({this.leadershipTypeId, this.leadershipTypeName});

  LeadershipType.fromJson(Map<String, dynamic> json) {
    leadershipTypeId = json[DbConstants.leadershipId];
    leadershipTypeName = json[DbConstants.leadershipName];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.leadershipId] = leadershipTypeId;
    data[DbConstants.leadershipName] = leadershipTypeName;
    return data;
  }
}
