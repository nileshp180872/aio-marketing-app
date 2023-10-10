import 'package:aio/config/app_assets.dart';
import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
            child: Image.network("${NetworkConstants.kImageBasePath}$image"),
          ),
        ),
      ],
    );
  }
}
