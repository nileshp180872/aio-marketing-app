class DomainResponse {
  List<DomainResponseData>? data;

  DomainResponse({this.data});

  DomainResponse.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      data = <DomainResponseData>[];
      json['data'].forEach((v) {
        data!.add(DomainResponseData.fromJson(v));
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

class DomainResponseData {
  String? id;
  String? domainName;
  String? modifiedOn;
  String? deletedOn;
  bool? isEnable;
  bool? isDeleted;

  DomainResponseData({this.id, this.domainName,this.modifiedOn,
    this.deletedOn,
    this.isEnable,
    this.isDeleted});

  DomainResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainName = json['domain_name'];
    modifiedOn = json['modified_on'];
    deletedOn = json['deleted_on'];
    isEnable = json['is_enable'];
    isDeleted = json['is_deleted'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['domain_name'] = this.domainName;
    data['modified_on'] = this.modifiedOn;
    data['deleted_on'] = this.deletedOn;
    data['is_enable'] = this.isEnable;
    data['is_deleted'] = this.isDeleted;
    return data;
  }
}