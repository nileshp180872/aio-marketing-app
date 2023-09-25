import 'package:aio/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../model/project_list_model.dart';

class ProjectListGridTileWidget extends StatelessWidget {
  ProjectListModel projectListModel;
  Function(ProjectListModel model) onClick;

  ProjectListGridTileWidget(
      {required this.projectListModel, required this.onClick, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => onClick(projectListModel),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
        ),
        child: Column(
          children: [
            Expanded(
              child: Image.asset(
                projectListModel.projectImage ?? "",
                fit: BoxFit.cover,
              ),
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 12),
              child: Text(
                projectListModel.projectName ?? "",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: _textTheme.labelLarge
                    ?.copyWith(color: AppColors.colorSecondary),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
