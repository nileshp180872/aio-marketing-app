import 'package:aio/presentation/project_detail/view/project_image_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class ProjectImageTileWidget extends StatelessWidget {
  double itemWidth;
  String imagePath;
  int index;
  Function(int index) selectImage;

  ProjectImageTileWidget(
      {required this.itemWidth,
      this.imagePath = "",
      required this.index,
      required this.selectImage,
      super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => selectImage(index),
      child: Container(
        width: itemWidth,
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.colorSecondary.withOpacity(0.15),
        ),
        padding: const EdgeInsets.all(1),
        child: ProjectImageWidget(imageURL: imagePath),
      ),
    );
  }
}
