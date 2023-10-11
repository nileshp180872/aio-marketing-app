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
  String? solutionImage1;
  String? solutionImage2;
  String? solutionImage3;
  String? solutionTitle1;
  String? solutionTitle2;
  String? solutionTitle3;
  String? solutionDescription1;
  String? solutionDescription2;
  String? solutionDescription3;
  String? businessDescription1;
  String? businessDescription2;
  String? businessDescription3;
  String? companyDescription;
  String? companyImage;
  String? businessImage1;
  String? businessImage2;
  String? businessImage3;
  String? businessTitle1;
  String? businessTitle2;
  String? businessTitle3;
  List<String>? techMapping = [];
  List<String>? sliderImages = [];

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
      this.companyImage,
      this.solutionTitle1,
      this.solutionTitle2,
      this.solutionTitle3,
      this.solutionImage1,
      this.solutionImage2,
      this.solutionImage3,
      this.solutionDescription1,
      this.solutionDescription2,
      this.solutionDescription3,
      this.businessDescription1,
      this.businessDescription2,
      this.businessDescription3,
      this.companyDescription,
      this.businessImage1,
      this.businessImage2,
      this.businessImage3,
        this.businessTitle1,
        this.techMapping,
        this.sliderImages,
      this.businessTitle2,
      this.businessTitle3,
      this.description});
}
