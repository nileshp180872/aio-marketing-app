import 'package:aio/infrastructure/network/model/portfolio_response.dart';

class LeadersResponse {
  bool? success;
  int? status;
  String? message;
  List<LeadersResponseData>? data;

  LeadersResponse({this.success, this.status, this.message, this.data});

  LeadersResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <LeadersResponseData>[];
      json['data'].forEach((v) { data!.add(new LeadersResponseData.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadersResponseData {
  String? leadershipID;
  String? designation;
  String? leaderNAME;
  String? description;
  List<LeaderImageMapping>? imageMapping;

  LeadersResponseData({this.leadershipID, this.designation, this.leaderNAME, this.description});

  LeadersResponseData.fromJson(Map<String, dynamic> json) {
    leadershipID = json['LeadershipID'];
    designation = json['Designation'];
    leaderNAME = json['LeaderName'];
    description = json['Description'];
    if (json['ImageMapping'] != null) {
      imageMapping = <LeaderImageMapping>[];
      json['ImageMapping'].forEach((v) { imageMapping!.add(new LeaderImageMapping.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadershipID'] = leadershipID;
    data['Designation'] = designation;
    data['LeaderName'] = leaderNAME;
    data['Description'] = description;
    if (this.imageMapping != null) {
      data['ImageMapping'] = this.imageMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class LeaderImageMapping {
  String? leadershipID;
  String? leaderImage;

  LeaderImageMapping({this.leadershipID, this.leaderImage});

  LeaderImageMapping.fromJson(Map<String, dynamic> json) {
    leadershipID = json['LeadershipID'];
    leaderImage = json['LeaderImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadershipID'] = this.leadershipID;
    data['LeaderImage'] = this.leaderImage;
    return data;
  }
}
