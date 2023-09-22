import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class ProjectImageTileWidget extends StatelessWidget {
  double itemWidth;

  ProjectImageTileWidget({required this.itemWidth, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: itemWidth,
      height: 100,
      decoration: BoxDecoration(
        color: AppColors.colorSecondary.withOpacity(0.15),
      ),
      padding: const EdgeInsets.all(16),
      child: Image.asset('assets/images/sample_image.png'),
    );
  }
}
