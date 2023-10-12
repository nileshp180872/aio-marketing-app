import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../project_detail/view/project_image_widget.dart';

class TechnologySignleTileWidget extends StatelessWidget {
  String image;
  late TextTheme _textTheme;

  TechnologySignleTileWidget({required this.image, super.key});

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: SizedBox(
            height: 70,
            width: 70,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: ProjectImageWidget(imageURL: image)),
            ),
          ),
        ),
      ],
    );
  }
}
