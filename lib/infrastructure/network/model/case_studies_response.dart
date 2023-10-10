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
        data!.add(CaseStudiesResponseData.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
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
  String? modifiedOn;
  String? companyTitle;
  String? companyName;
  String? companyDescription;
  String? businessTitle;
  String? businessImage;
  String? businessDescription;
  String? solutionTitle;
  String? solutionDescription;
  String? solutionImage;
  String? document;
  String? companyImage;
  String? bannerImage;
  String? thumbnailImage;
  String? urlLink;
  bool? isEnabled;
  bool? isDeleted;
  List<CaseStudyTechMapping>? techMapping;
  List<CaseStudyImageMapping>? imageMapping;

  CaseStudiesResponseData(
      {this.casestudiesID,
      this.domainID,
      this.projectName,
      this.description,
      this.isEnabled,
      this.isDeleted,
      this.modifiedOn,
      this.imageMapping,
      this.domainName,
      this.companyName,
      this.companyDescription,
      this.businessTitle,
      this.businessDescription,
      this.solutionTitle,
      this.solutionDescription,
      this.solutionImage,
      this.document,
      this.companyImage,
      this.bannerImage,
      this.thumbnailImage,
      this.urlLink,
      this.techMapping});

  CaseStudiesResponseData.fromJson(Map<String, dynamic> json) {
    casestudiesID = json['CasestudiesID'];
    domainID = json['DomainID'];
    projectName = json['ProjectName'];
    description = json['Description'];
    domainName = json['DomainName'];

    isEnabled = json['is_enabled'];
    isDeleted = json['is_deleted'];
    modifiedOn = json['modified_on'];
    urlLink = json['URLLink'];
    companyTitle = json['CompanyTitle'];
    companyDescription = json['CompanyDescription'];
    businessTitle = json['BusinessTitle'];
    businessDescription = json['BusinessDescription'];
    solutionTitle = json['SolutionTitle'];
    solutionDescription = json['SolutionDescription'];
    document = json['Documents'];
    companyImage = json['ComapnyImage'];
    businessImage = json['BusinessImage'];
    solutionImage = json['SolutionImage'];
    thumbnailImage = json['ThumbnailImages'];
    bannerImage = json['BannerImage'];
    companyName = json['CompanyName'];
    if (json['TechMapping'] != null) {
      techMapping = <CaseStudyTechMapping>[];
      json['TechMapping'].forEach((v) {
        techMapping!.add(CaseStudyTechMapping.fromJson(v));
      });
    }
    if (json['ImageMapping'] != null) {
      imageMapping = <CaseStudyImageMapping>[];
      json['ImageMapping'].forEach((v) {
        imageMapping!.add(CaseStudyImageMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CasestudiesID'] = casestudiesID;
    data['DomainID'] = domainID;
    data['ProjectName'] = projectName;
    data['Description'] = description;
    data['DomainName'] = domainName;
    data['is_enabled'] = isEnabled;
    data['is_deleted'] = isDeleted;
    data['CompanyName'] = companyName;
    data['BannerImage'] = bannerImage;
    data['ThumbnailImages'] = thumbnailImage;
    data['SolutionImage'] = solutionImage;
    data['BusinessImage'] = businessImage;
    data['ComapnyImage'] = companyImage;
    data['Documents'] = document;
    data['SolutionDescription'] = solutionDescription;
    data['SolutionTitle'] = solutionTitle;
    data['BusinessDescription'] = businessDescription;
    data['BusinessTitle'] = businessTitle;
    data['CompanyDescription'] = companyDescription;
    data['CompanyTitle'] = companyTitle;
    data['URLLink'] = urlLink;
    data['modified_on'] = modifiedOn;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['PortfolioID'] = portfolioID;
    data['PortfolioImage'] = portfolioImage;
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
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['casestudiesID'] = casestudiesID;
    data['casestudiesImage'] = casestudiesImage;
    return data;
  }
}

class CaseStudyTechMapping {
  String? id;
  String? casestudiesId;
  String? techId;
  String? techName;

  CaseStudyTechMapping(
      {this.id, this.casestudiesId, this.techId, this.techName});

  CaseStudyTechMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casestudiesId = json['casestudies_id'];
    techId = json['tech_id'];
    techName = json['TechName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['casestudies_id'] = casestudiesId;
    data['tech_id'] = techId;
    data['TechName'] = techName;
    return data;
  }
}
