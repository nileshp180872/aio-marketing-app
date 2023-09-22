import 'package:flutter/material.dart';

import '../model/project_list_model.dart';

class ProjectListTileWidget extends StatelessWidget {
  ProjectListModel projectListModel;
  Function(ProjectListModel model) onClick;

  ProjectListTileWidget(
      {required this.projectListModel, required this.onClick, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => onClick(projectListModel),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        child: Text(
          projectListModel.projectName ?? "",
          style: _textTheme.bodySmall,
        ),
      ),
    );
  }
}