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
    leaderId = json[DbConstants.leaderId];
    leaderName = json[DbConstants.leaderName];
    image = json[DbConstants.leaderImage];
    designation = json[DbConstants.leaderDesignation];
    description = json[DbConstants.leaderDescription];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.leaderId] = leaderId;
    data[DbConstants.leaderName] = leaderName;
    data[DbConstants.leaderImage] = image;
    data[DbConstants.leaderDesignation] = designation;
    data[DbConstants.leaderDescription] = description;
    return data;
  }
}
