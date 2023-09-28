class ProjectListModel{
  String? projectName;
  String? id;
  int? autoIncrementId;
  String? technologies;
  String? overView;
  String? description;
  String? projectImage;
  int? viewType;

  ProjectListModel(
      {this.id,this.autoIncrementId,this.viewType,this.projectName,this.projectImage, this.technologies, this.overView, this.description});
}