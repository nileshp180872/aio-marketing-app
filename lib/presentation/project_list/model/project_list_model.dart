class ProjectListModel {
  String? projectName;
  String? id;
  int? autoIncrementId;
  String? technologies;
  String? overView;
  String? description;
  String? projectImage;
  List<String>? networkImages;
  int? viewType;

  ProjectListModel(
      {this.id,
      this.autoIncrementId,
      this.viewType,
      this.projectName,
      this.projectImage,
      this.networkImages,
      this.technologies,
      this.overView,
      this.description});
}
