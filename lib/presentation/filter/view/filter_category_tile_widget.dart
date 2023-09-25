import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:flutter/material.dart';

class FilterCategoryTileWidget extends StatelessWidget {
  String text;
  bool isSelected;
  int index;
  Function(int index) onClick;

  FilterCategoryTileWidget(
      {required this.text,
      required this.isSelected,
      required this.index,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () => onClick(index),
      child: Container(
          color: isSelected
              ? AppColors.colorSecondary
              : Colors.grey.withOpacity(0.2),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: Text(
            text,
            style: textTheme.labelMedium
                ?.copyWith(
                  fontSize: 22,
                  fontFamily: AppConstants.sourceSansPro,
                  fontWeight: FontWeight.w500,
                )
                ?.copyWith(color: isSelected ? Colors.white : null),
          )),
    );
  }
}
