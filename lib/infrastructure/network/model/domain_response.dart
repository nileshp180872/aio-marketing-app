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

  DomainResponseData({this.id, this.domainName});

  DomainResponseData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    domainName = json['domain_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['domain_name'] = this.domainName;
    return data;
  }
}