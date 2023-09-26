class LeadershipTypeResponse {
  List<LeadershipTypeData>? data;

  LeadershipTypeResponse({this.data});

  LeadershipTypeResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <LeadershipTypeData>[];
      json['data'].forEach((v) {
        data!.add(LeadershipTypeData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class LeadershipTypeData {
  String? id;
  String? leaderType;

  LeadershipTypeData({this.id, this.leaderType});

  LeadershipTypeData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    leaderType = json['leader_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['leader_type'] = this.leaderType;
    return data;
  }
}