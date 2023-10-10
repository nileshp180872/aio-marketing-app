import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_strings.dart';
import 'package:flutter/material.dart';

import '../model/business_challenge.dart';

class BusinessChallengeSingleTileWidget extends StatelessWidget {
  BusinessChallenge model;
  late TextTheme _textTheme;

  BusinessChallengeSingleTileWidget({required this.model, super.key});

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;

    return Container(
      child: Row(
        children: [
          Container(
            height: 70,
            width: 70,
            child: Image.asset(AppAssets.caseStudyChallenges),
          ),
          SizedBox(
            width: 16.0,
          ),
          Expanded(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.title ?? "",
                style: _textTheme.bodyLarge
                    ?.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                model.description ?? "",
                style: _textTheme.bodyLarge
                    ?.copyWith(fontSize: 12, fontWeight: FontWeight.w400),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
