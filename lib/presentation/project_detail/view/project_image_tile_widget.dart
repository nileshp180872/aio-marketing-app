import 'dart:io';

import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class ProjectImageTileWidget extends StatelessWidget {
  double itemWidth;
  String imagePath;
  int index;
  bool selected;
  Function(int index) selectImage;

  ProjectImageTileWidget(
      {required this.itemWidth,
      this.imagePath = "",
      required this.index,
      required this.selected,
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
            border: Border.all(
                color:
                    selected ? AppColors.colorSecondary : Colors.transparent)),
        padding: const EdgeInsets.all(16),
        child: Image.file(File(imagePath)),
      ),
    );
  }
}
