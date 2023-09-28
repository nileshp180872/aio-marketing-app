import 'dart:convert';

import '../db_constants.dart';

class Portfolio {
  int? portfolioAutoIncrementId;
  String? portfolioId;
  String? portfolioDomainId;
  String? portfolioDomainName;
  String? portfolioScreenTypeId;
  String? portfolioScreenTypeName;
  String? portfolioProjectName;
  String? portfolioProjectDescription;
  String? images;
  List<String>? projectImages;

  Portfolio(
      {this.portfolioAutoIncrementId,
      this.portfolioId,
      this.portfolioDomainId,
      this.portfolioDomainName,
      this.portfolioScreenTypeId,
      this.portfolioScreenTypeName,
      this.portfolioProjectName,
      this.projectImages,
      this.images,
      this.portfolioProjectDescription});

  Portfolio.fromJson(Map<String, dynamic> json) {
    portfolioAutoIncrementId = json[DbConstants.portfolioAIId];
    portfolioId = json[DbConstants.portfolioId];
    portfolioDomainId = json[DbConstants.portfolioDomainId];
    portfolioDomainName = json[DbConstants.portfolioDomainName];
    portfolioScreenTypeId = json[DbConstants.portfolioScreenType];
    portfolioScreenTypeName = json[DbConstants.portfolioScreenName];
    portfolioProjectName = json[DbConstants.portfolioProjectName];
    portfolioProjectDescription = json[DbConstants.portfolioProjectDescription];
    images = json[DbConstants.images];
    if (json[DbConstants.projectImages] != null) {
      projectImages = <String>[];
      (json[DbConstants.projectImages].split(" ")).forEach((v) {
        projectImages!.add(v);
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[DbConstants.portfolioAIId] = portfolioAutoIncrementId;
    data[DbConstants.portfolioId] = portfolioId;
    data[DbConstants.portfolioDomainId] = portfolioDomainId;
    data[DbConstants.portfolioDomainName] = portfolioDomainName;
    data[DbConstants.portfolioScreenType] = portfolioScreenTypeId;
    data[DbConstants.portfolioScreenName] = portfolioScreenTypeName;
    data[DbConstants.portfolioProjectName] = portfolioProjectName;
    data[DbConstants.portfolioProjectDescription] = portfolioProjectDescription;

    if (projectImages != null) {
      var json = jsonEncode(projectImages, toEncodable: (e) => e!.toString());

      data[DbConstants.projectImages] = json;
    }
    return data;
  }
}
