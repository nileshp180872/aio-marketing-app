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
  List<Null>? techMapping;

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
    screenTYPE = json['ScreenTYPE'];
    screenNAME = json['ScreenNAME'];
    projectName = json['project_name'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['PortfolioID'] = this.portfolioID;
    data['DomainID'] = this.domainID;
    data['DomainName'] = this.domainName;
    data['ScreenTYPE'] = this.screenTYPE;
    data['ScreenNAME'] = this.screenNAME;
    data['project_name'] = this.projectName;
    data['description'] = this.description;
    return data;
  }
}
