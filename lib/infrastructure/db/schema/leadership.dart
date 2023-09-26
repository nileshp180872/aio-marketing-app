import '../db_constants.dart';

class Leadership {
  String? leaderId;
  String? leaderName;
  String? designation;
  String? description;
  String? image;

  Leadership(
      {this.leaderId,
      this.leaderName,
      this.designation,
      this.description,
      this.image});

  Leadership.fromJson(Map<String, dynamic> json) {
    leaderId = json[DbConstants.leadershipId];
    leaderName = json[DbConstants.leadershipName];
    image = json[DbConstants.leadershipName];
    designation = json[DbConstants.leadershipName];
    description = json[DbConstants.leadershipName];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.leadershipId] = leaderId;
    data[DbConstants.leadershipName] = leaderName;
    data[DbConstants.leadershipName] = image;
    data[DbConstants.leadershipName] = designation;
    data[DbConstants.leadershipName] = description;
    return data;
  }
}
