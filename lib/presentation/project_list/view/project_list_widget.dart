import 'package:aio/presentation/project_list/view/project_list_grid_tile_widget.dart';
import 'package:aio/presentation/project_list/view/project_list_tile_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../model/project_list_model.dart';

class ProjectListWidget extends StatelessWidget {
  List<ProjectListModel> projectList = [];


  Function(ProjectListModel model, int index) onClick;

  late TextTheme _textTheme;

  bool isLoading;

  ProjectListWidget(
      {required this.projectList,
      this.isLoading = false,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return isLoading ? _buildLoadingIndicator() : _buildProjectGridList();
  }

  /// Build project list header widget.
  Widget _buildProjectListHeader() {
    return Container(
      color: AppColors.headerBackground,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        AppStrings.project.toUpperCase(),
        style: _textTheme.titleSmall?.copyWith(
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  /// Build project list
  Widget _buildProjectList() {
    return ListView.separated(
      shrinkWrap: true,
      itemCount: projectList.length,
      itemBuilder: (ctx, index) {
        return ProjectListTileWidget(
          projectListModel: projectList[index],
          onClick: onClick,
          index: index,
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return Container(
          height: 1,
          color: AppColors.colorSecondary.withOpacity(0.5),
        );
      },
    );
  }

  /// Build project grid list view
  Widget _buildProjectGridList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 1.1),
      shrinkWrap: true,
      itemCount: projectList.length,
      itemBuilder: (ctx, index) {
        return ProjectListGridTileWidget(
          projectListModel: projectList[index],
          onClick: onClick,
          index: index,
        );
      },
    );
  }

  /// Build loading indicator
  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }
}
