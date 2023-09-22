import 'package:aio/presentation/project_list/view/project_list_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../model/project_list_model.dart';

class ProjectListWidget extends StatelessWidget {
  List<ProjectListModel> projectList = [];

  Function(ProjectListModel model) onClick;
  late TextTheme _textTheme;

  ProjectListWidget(
      {required this.projectList, required this.onClick, super.key});

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: AppColors.colorSecondary.withOpacity(0.5))),
      child: Column(
        children: [
          _buildProjectListHeader(),
          Container(
            height: 1,
            color: AppColors.colorSecondary.withOpacity(0.5),
          ),
          Expanded(child: _buildProjectList()),
        ],
      ),
    );
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
}
