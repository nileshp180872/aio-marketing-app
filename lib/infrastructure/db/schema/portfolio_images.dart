import '../db_constants.dart';

class PortfolioImages {
  String? portfolioImageId;
  String? portfolioImagePath;
  String? portfolioImagePortfolioId;

  PortfolioImages(
      {this.portfolioImageId,
      this.portfolioImagePath,
      this.portfolioImagePortfolioId});

  PortfolioImages.fromJson(Map<String, dynamic> json) {
    portfolioImageId = json[DbConstants.portfolioImageId];
    portfolioImagePath = json[DbConstants.portfolioImagePath];
    portfolioImagePortfolioId = json[DbConstants.portfolioImagePortfolioId];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.portfolioImageId] = portfolioImageId;
    data[DbConstants.portfolioImagePath] = portfolioImagePath;
    data[DbConstants.portfolioImagePortfolioId] = portfolioImagePortfolioId;
    return data;
  }
}
