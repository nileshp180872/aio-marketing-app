import 'package:aio/infrastructure/network/model/portfolio_response.dart';

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
    data['success'] = success;
    data['status'] = status;
    data['message'] = message;
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
  List<CaseStudyImageMapping>? imageMapping;

  CaseStudiesResponseData(
      {this.casestudiesID,
      this.domainID,
      this.projectName,
      this.description,
      this.imageMapping,
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
    if (json['ImageMapping'] != null) {
      imageMapping = <CaseStudyImageMapping>[];
      json['ImageMapping'].forEach((v) {
        imageMapping!.add(new CaseStudyImageMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['casestudiesID'] = casestudiesID;
    data['DomainID'] = domainID;
    data['project_name'] = projectName;
    data['description'] = description;
    data['DomainName'] = domainName;
    if (techMapping != null) {
      data['TechMapping'] = techMapping!.map((v) => v.toJson()).toList();
    }
    if (imageMapping != null) {
      data['ImageMapping'] = imageMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ImageMapping {
  String? portfolioID;
  String? portfolioImage;

  ImageMapping({this.portfolioID, this.portfolioImage});

  ImageMapping.fromJson(Map<String, dynamic> json) {
    portfolioID = json['PortfolioID'];
    portfolioImage = json['PortfolioImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PortfolioID'] = this.portfolioID;
    data['PortfolioImage'] = this.portfolioImage;
    return data;
  }
}
class CaseStudyImageMapping {
  String? casestudiesID;
  String? casestudiesImage;

  CaseStudyImageMapping({this.casestudiesID, this.casestudiesImage});

  CaseStudyImageMapping.fromJson(Map<String, dynamic> json) {
    casestudiesID = json['casestudiesID'];
    casestudiesImage = json['casestudiesImage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['casestudiesID'] = this.casestudiesID;
    data['casestudiesImage'] = this.casestudiesImage;
    return data;
  }
}