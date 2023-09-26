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

  LeadersResponseData({this.leadershipID, this.designation, this.leaderNAME, this.description});

  LeadersResponseData.fromJson(Map<String, dynamic> json) {
    leadershipID = json['LeadershipID'];
    designation = json['designation'];
    leaderNAME = json['LeaderNAME'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['LeadershipID'] = leadershipID;
    data['designation'] = designation;
    data['LeaderNAME'] = leaderNAME;
    data['description'] = description;
    return data;
  }
}