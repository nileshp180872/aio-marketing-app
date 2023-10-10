import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';

class SectionHeaderWidget extends StatelessWidget {
  String title;
  SectionHeaderWidget({required this.title,super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: const TextStyle(
              color: AppColors.colorSecondary,
              fontSize: 32,
              fontWeight: FontWeight.w700),
        ),
        const SizedBox(
          height: 5,
        ),
        Container(
          width: 50,
          height: 5,
          color: AppColors.colorPrimary,
        )
      ],
    );
  }
}
