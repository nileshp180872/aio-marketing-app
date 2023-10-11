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
        SizedBox(
          height: 70,
          width: 70,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: ProjectImageWidget(imageURL: image),
          ),
        ),
      ],
    );
  }
}
