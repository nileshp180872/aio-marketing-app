import '../db_constants.dart';

class PortfolioTechnologies {
  String? portfolioTechnologyId;
  String? portfolioTechnologyName;
  String? portfolioTechnologyPortfolioId;

  PortfolioTechnologies(
      {this.portfolioTechnologyId,
      this.portfolioTechnologyName,
      this.portfolioTechnologyPortfolioId});

  PortfolioTechnologies.fromJson(Map<String, dynamic> json) {
    portfolioTechnologyId = json[DbConstants.portfolioTechnologyId];
    portfolioTechnologyName = json[DbConstants.portfolioTechnologyName];
    portfolioTechnologyPortfolioId = json[DbConstants.portfolioTableId];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.portfolioTechnologyId] = portfolioTechnologyId;
    data[DbConstants.portfolioTechnologyName] = portfolioTechnologyName;
    data[DbConstants.portfolioTableId] = portfolioTechnologyPortfolioId;
    return data;
  }
}
