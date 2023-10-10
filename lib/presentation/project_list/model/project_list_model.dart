class ProjectListModel {
  String? projectName;
  String? id;
  int? autoIncrementId;
  String? technologies;
  String? overView;
  String? description;
  String? projectImage;
  String? urlLink;
  List<String>? networkImages;
  int? viewType;
  String? casestudyThumbnailImage;
  String? casestudyBannerImage;
  String? domainName;
  String? companyName;
  String? conclusion;
  String? solutionTitle;
  String? solutionDescription;
  String? businessDescription1;
  String? businessDescription2;
  String? businessDescription3;
  String? companyDescription;
  String? businessImage1;
  String? businessImage2;
  String? businessImage3;

  ProjectListModel(
      {this.id,
      this.autoIncrementId,
      this.viewType,
      this.projectName,
      this.projectImage,
      this.networkImages,
      this.urlLink,
      this.technologies,
      this.overView,
      this.casestudyThumbnailImage,
      this.casestudyBannerImage,
      this.domainName,
      this.companyName,
      this.conclusion,
      this.solutionTitle,
      this.solutionDescription,
      this.businessDescription1,
      this.businessDescription2,
      this.businessDescription3,
      this.companyDescription,
      this.businessImage1,
      this.businessImage2,
      this.businessImage3,
      this.description});
}
