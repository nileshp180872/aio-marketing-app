import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';
import '../../project_detail/view/project_image_widget.dart';
import '../model/project_list_model.dart';

class ProjectListGridTileWidget extends StatelessWidget {
  ProjectListModel projectListModel;
  Function(ProjectListModel model, int index) onClick;
  int index;
  bool isForSearch;

  ProjectListGridTileWidget(
      {required this.projectListModel,
      required this.onClick,
      required this.index,
      this.isForSearch = false,
      super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return isForSearch
        ? badges.Badge(
            badgeStyle: badges.BadgeStyle(
              shape: badges.BadgeShape.square,
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(color: Colors.white, width: 2),
              badgeColor: AppColors.colorPrimary,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            ),
            badgeContent: Text(
                projectListModel.viewType == AppConstants.portfolio ? 'P' : 'C',
                style: _textTheme.bodyMedium?.copyWith(color: Colors.white)),
            position: badges.BadgePosition.topEnd(top: 8, end: 10),
            child: cardData(),
          )
        : cardData();
  }

  ///Build the content
  Widget cardData() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: InkWell(
        onTap: () => onClick(projectListModel, index),
        child: Column(
          children: [
            Expanded(
              child: (projectListModel.networkImages ?? []).isNotEmpty
                  ? ProjectImageWidget(
                      imageURL: projectListModel.casestudyThumbnailImage ?? "",
                    )
                  : _buildNoDataImage(),
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

  Widget _buildNoDataImage() {
    return Image.asset(
      AppAssets.kNoImage,
      fit: BoxFit.cover,
    );
  }
}
