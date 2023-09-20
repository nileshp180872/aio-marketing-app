class TechnologyResponse {
  List<TechnologyResponseData>? data;

  TechnologyResponse({this.data});

  TechnologyResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <TechnologyResponseData>[];
      json['data'].forEach((v) {
        data!.add(new TechnologyResponseData.fromJson(v));
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

class TechnologyResponseData {
  String? id;
  String? techName;

  TechnologyResponseData({this.id, this.techName});

  TechnologyResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    techName = json['tech_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tech_name'] = this.techName;
    return data;
  }
}
