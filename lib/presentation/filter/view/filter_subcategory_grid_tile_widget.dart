import 'package:aio/config/app_colors.dart';
import 'package:flutter/material.dart';

import '../model/selection_model.dart';

class FilterSubCategoryGridTileWidget extends StatelessWidget {
  SelectionModel text;

  int index;
  Function(int index) onTapItem;

  FilterSubCategoryGridTileWidget(
      {required this.text,
      required this.index,
      required this.onTapItem,
      super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return InkWell(
      onTap: () {
        onTapItem(index);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: AppColors.cardBackground,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
                value: text.selected,
                onChanged: (ds) {
                  onTapItem(index);
                }),
            Text(
              text.title ?? "",
              style: textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.normal),
            )
          ],
        ),
      ),
    );
  }
}
