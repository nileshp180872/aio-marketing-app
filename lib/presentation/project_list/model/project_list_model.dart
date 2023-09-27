class ProjectListModel{
  String? projectName;
  String? id;
  String? technologies;
  String? overView;
  String? description;
  String? projectImage;
  int? viewType;

  ProjectListModel(
      {this.id,this.viewType,this.projectName,this.projectImage, this.technologies, this.overView, this.description});
}