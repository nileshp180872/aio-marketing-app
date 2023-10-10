import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_strings.dart';
import 'package:flutter/material.dart';

import '../model/business_challenge.dart';

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
          height: 90,
          width: 90,
          child: Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Image.asset(AppAssets.caseStudyChallenges),
          ),
        ),
      ],
    );
  }
}
