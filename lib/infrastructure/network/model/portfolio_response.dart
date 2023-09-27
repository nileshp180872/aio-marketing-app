class PortfolioResponse {
  bool? success;
  int? status;
  String? message;
  List<PortfolioResponseData>? data;

  PortfolioResponse({
    this.success,
    this.status,
    this.message,
    this.data,
  });

  PortfolioResponse.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PortfolioResponseData>[];
      json['data'].forEach((v) {
        data!.add(new PortfolioResponseData.fromJson(v));
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

class PortfolioResponseData {
  String? portfolioID;
  String? domainID;
  String? domainName;
  String? screenTYPE;
  String? screenNAME;
  String? projectName;
  String? description;
  List<TechMapping>? techMapping;
  List<ImageMapping>? imageMapping;


  PortfolioResponseData(
      {this.portfolioID,
      this.domainID,
      this.domainName,
      this.screenTYPE,
      this.screenNAME,
      this.projectName,
      this.description,
      this.techMapping});

  PortfolioResponseData.fromJson(Map<String, dynamic> json) {
    portfolioID = json['PortfolioID'];
    domainID = json['DomainID'];
    domainName = json['DomainName'];
    screenTYPE = json['ScreenType'];
    screenNAME = json['ScreenName'];
    projectName = json['ProjectName'];
    description = json['Description'];
    if (json['TechMapping'] != null) {
      techMapping = <TechMapping>[];
      json['TechMapping'].forEach((v) { techMapping!.add(new TechMapping.fromJson(v)); });
    }
    if (json['ImageMapping'] != null) {
      imageMapping = <ImageMapping>[];
      json['ImageMapping'].forEach((v) { imageMapping!.add(new ImageMapping.fromJson(v)); });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PortfolioID'] = this.portfolioID;
    data['DomainID'] = this.domainID;
    data['DomainName'] = this.domainName;
    data['ScreenType'] = this.screenTYPE;
    data['ScreenName'] = this.screenNAME;
    data['ProjectName'] = this.projectName;
    data['Description'] = this.description;
    if (this.techMapping != null) {
      data['TechMapping'] = this.techMapping!.map((v) => v.toJson()).toList();
    }
    if (this.imageMapping != null) {
      data['ImageMapping'] = this.imageMapping!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
class TechMapping {
  String? portfolioID;
  String? caseStudyID;
  String? techID;
  String? techName;

  TechMapping({this.portfolioID,this.caseStudyID, this.techID, this.techName});

  TechMapping.fromJson(Map<String, dynamic> json) {
    portfolioID = json['PortfolioID'];
    caseStudyID = json['casestudies_id'];
    techID = json['TechID'];
    techName = json['TechName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PortfolioID'] = this.portfolioID;
    data['casestudies_id'] = this.caseStudyID;
    data['TechID'] = this.techID;
    data['TechName'] = this.techName;
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
