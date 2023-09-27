import 'dart:io';

import 'package:aio/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';
import '../model/project_list_model.dart';

class ProjectListGridTileWidget extends StatelessWidget {
  ProjectListModel projectListModel;
  Function(ProjectListModel model, int index) onClick;
  int index;

  ProjectListGridTileWidget(
      {required this.projectListModel, required this.onClick,required this.index, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => onClick(projectListModel, index),
      child: Container(
        decoration: const BoxDecoration(
          color: AppColors.cardBackground,
        ),
        child: Column(
          children: [
            Expanded(
              child: (projectListModel.projectImage ?? "").isNotEmpty
                  ? Image.file(
                      File(projectListModel.projectImage ?? ""),
                      fit: BoxFit.cover,
                    )
                  : Image.asset(
                      AppAssets.kNoImage,
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
