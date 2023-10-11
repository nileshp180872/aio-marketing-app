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
  String? description1;
  String? description2;
  String? description3;
  String? domainName;
  String? modifiedOn;
  String? companyTitle;
  String? companyName;
  String? companyDescription;
  String? businessTitle;
  String? businessTitle1;
  String? businessTitle2;
  String? businessTitle3;
  String? businessImage;
  String? businessImage1;
  String? businessImage2;
  String? businessImage3;
  String? businessDescription;
  String? solutionTitle1;
  String? solutionDescription1;
  String? solutionImage1;
  String? solutionTitle2;
  String? solutionDescription2;
  String? solutionImage2;
  String? solutionTitle3;
  String? solutionDescription3;
  String? solutionImage3;
  String? document;
  String? companyImage;
  String? bannerImage;
  String? thumbnailImage;
  String? conclusion;
  String? urlLink;
  bool? isEnabled;
  bool? isDeleted;
  List<CaseStudyTechMapping>? techMapping;
  List<CaseStudyImageMapping>? imageMapping;
  List<CaseStudyTechMapping>? techImageMapping;

  CaseStudiesResponseData(
      {this.casestudiesID,
      this.domainID,
      this.projectName,
      this.description1,
      this.description2,
      this.description3,
      this.isEnabled,
      this.isDeleted,
      this.modifiedOn,
      this.imageMapping,
      this.domainName,
      this.companyName,
      this.companyDescription,
      this.businessTitle,
      this.businessDescription,
      this.solutionTitle1,
      this.solutionTitle2,
      this.solutionTitle3,
      this.conclusion,
      this.businessTitle1,
      this.businessTitle2,
      this.businessTitle3,
      this.solutionDescription1,
      this.solutionDescription2,
      this.solutionDescription3,
      this.solutionImage1,
      this.solutionImage2,
      this.solutionImage3,
      this.document,
      this.techImageMapping,
      this.companyImage,
      this.bannerImage,
      this.thumbnailImage,
      this.urlLink,
      this.techMapping});

  CaseStudiesResponseData.fromJson(Map<String, dynamic> json) {
    casestudiesID = json['CasestudiesID'];
    domainID = json['DomainID'];
    projectName = json['ProjectName'];
    description1 = json['BusinessDescription1'];
    description2 = json['BusinessDescription2'];
    description3 = json['BusinessDescription3'];
    domainName = json['DomainName'];

    isEnabled = json['is_enabled'];
    isDeleted = json['is_deleted'];
    modifiedOn = json['modified_on'];
    conclusion = json['Conclusion'];
    urlLink = json['URLLink'];
    companyTitle = json['CompanyTitle'];
    companyDescription = json['CompanyDescription'];
    businessTitle = json['BusinessTitle'];
    businessDescription = json['BusinessDescription'];
    solutionTitle1 = json['SolutionTitle1'];
    solutionTitle2 = json['SolutionTitle2'];
    solutionTitle3 = json['SolutionTitle3'];
    solutionDescription1 = json['SolutionDescription1'];
    solutionDescription2 = json['SolutionDescription2'];
    solutionDescription3 = json['SolutionDescription3'];
    document = json['Documents'];
    companyImage = json['CompanyImage'];
    businessImage = json['BusinessImage'];
    solutionImage1 = json['SolutionImage1'];
    solutionImage2 = json['SolutionImage2'];
    solutionImage3 = json['SolutionImage3'];
    thumbnailImage = json['ThumbnailImages'];
    bannerImage = json['BannerImage'];
    businessTitle1 = json['BusinessTitle1'];
    businessTitle2 = json['BusinessTitle2'];
    businessTitle3 = json['BusinessTitle3'];
    businessImage1 = json['businessImages1'];
    businessImage2 = json['businessImages2'];
    businessImage3 = json['businessImages3'];
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
    if (json['TechImageMapping'] != null) {
      techImageMapping = <CaseStudyTechMapping>[];
      json['TechImageMapping'].forEach((v) {
        techImageMapping!.add(CaseStudyTechMapping.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['CasestudiesID'] = casestudiesID;
    data['DomainID'] = domainID;
    data['ProjectName'] = projectName;
    data['BusinessDescription1'] = description1;
    data['BusinessDescription2'] = description2;
    data['BusinessDescription3'] = description3;
    data['TechImageMapping'] = techImageMapping;
    data['DomainName'] = domainName;
    data['Conclusion'] = conclusion;
    data['is_enabled'] = isEnabled;
    data['is_deleted'] = isDeleted;
    data['CompanyName'] = companyName;
    data['BannerImage'] = bannerImage;
    data['ThumbnailImages'] = thumbnailImage;
    data['SolutionImage1'] = solutionImage1;
    data['SolutionImage2'] = solutionImage2;
    data['SolutionImage3'] = solutionImage3;
    data['BusinessImage'] = businessImage;
    data['ComapnyImage'] = companyImage;
    data['Documents'] = document;
    data['BusinessDescription1'] = description1;
    data['BusinessDescription2'] = description2;
    data['BusinessDescription3'] = description3;
    data['SolutionDescription1'] = solutionDescription1;
    data['SolutionDescription2'] = solutionDescription2;
    data['SolutionDescription3'] = solutionDescription3;
    data['SolutionTitle1'] = solutionTitle1;
    data['SolutionTitle2'] = solutionTitle2;
    data['SolutionTitle3'] = solutionTitle3;
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
  String? casestudiesImage2;

  CaseStudyImageMapping({this.casestudiesID, this.casestudiesImage});

  CaseStudyImageMapping.fromJson(Map<String, dynamic> json) {
    casestudiesID = json['casestudiesID'];
    casestudiesImage= json['casestudiesImage'];
    casestudiesImage2 = json['CaseTechImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['casestudiesID'] = casestudiesID;
    data['casestudiesImage'] = casestudiesImage;
    data['CaseTechImages'] = casestudiesImage2;
    return data;
  }
}

class CaseStudyTechMapping {
  String? id;
  String? casestudiesId;
  String? techId;
  String? techName;
  String? techImage;

  CaseStudyTechMapping(
      {this.id, this.casestudiesId, this.techId, this.techName});

  CaseStudyTechMapping.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    casestudiesId = json['casestudies_id'];
    techId = json['tech_id'];
    techName = json['TechName'];
    techImage = json['CaseTechImages'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['casestudies_id'] = casestudiesId;
    data['tech_id'] = techId;
    data['TechName'] = techName;
    data['CaseTechImages'] = techImage;
    return data;
  }
}
