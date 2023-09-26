class CaseStudiesResponse {
  bool? success;
  int? status;
  String? message;
  List<CaseStudiesResponseData>? data;

  CaseStudiesResponse({this.success, this.status, this.message, this.data});

  CaseStudiesResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <CaseStudiesResponseData>[];
      json['data'].forEach((v) {
        data!.add(new CaseStudiesResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class CaseStudiesResponseData {
  String? casestudiesID;
  String? domainID;
  String? projectName;
  String? description;
  String? domainName;
  List<TechMapping>? techMapping;

  CaseStudiesResponseData(
      {this.casestudiesID,
      this.domainID,
      this.projectName,
      this.description,
      this.domainName,
      this.techMapping});

  CaseStudiesResponseData.fromJson(Map<String, dynamic> json) {
    casestudiesID = json['casestudiesID'];
    domainID = json['DomainID'];
    projectName = json['project_name'];
    description = json['description'];
    domainName = json['DomainName'];
    if (json['TechMapping'] != null) {
      techMapping = <TechMapping>[];
      json['TechMapping'].forEach((v) {
        techMapping!.add(new TechMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['casestudiesID'] = this.casestudiesID;
    data['DomainID'] = this.domainID;
    data['project_name'] = this.projectName;
    data['description'] = this.description;
    data['DomainName'] = this.domainName;
    if (this.techMapping != null) {
      data['TechMapping'] = this.techMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class TechMapping {
  String? id;
  String? casestudiesId;
  String? techId;

  TechMapping({this.id, this.casestudiesId, this.techId});

  TechMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casestudiesId = json['casestudies_id'];
    techId = json['tech_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['casestudies_id'] = this.casestudiesId;
    data['tech_id'] = this.techId;
    return data;
  }
}
