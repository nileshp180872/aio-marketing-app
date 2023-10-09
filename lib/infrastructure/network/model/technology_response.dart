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
  String? modifiedOn;
  String? deletedOn;
  bool? isEnable;
  bool? isDeleted;

  TechnologyResponseData(
      {this.id,
      this.techName,
      this.modifiedOn,
      this.deletedOn,
      this.isEnable,
      this.isDeleted});

  TechnologyResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    techName = json['tech_name'];
    modifiedOn = json['modified_on'];
    deletedOn = json['deleted_on'];
    isEnable = json['is_enable'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['tech_name'] = this.techName;
    data['modified_on'] = modifiedOn;
    data['deleted_on'] = deletedOn;
    data['is_enable'] = isEnable;
    data['is_deleted'] = isDeleted;
    return data;
  }
}
