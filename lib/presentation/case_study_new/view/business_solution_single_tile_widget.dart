import 'package:aio/config/app_assets.dart';
import 'package:flutter/material.dart';

import '../model/business_challenge.dart';

class BusinessSolutionSingleTileWidget extends StatelessWidget {
  BusinessChallenge model;

  BusinessSolutionSingleTileWidget({required this.model, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Container(
      width: 250,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 50,
                width: 50,
                child: Image.asset(AppAssets.caseStudyChallenges),
              ),
              SizedBox(
                width: 16,
              ),
              Expanded(
                  child: Column(
                children: [
                  Text(
                    model.title ?? "",
                    style: _textTheme.bodyLarge
                        ?.copyWith(fontSize: 22, fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    model.description ?? "",
                    style: _textTheme.bodyLarge
                        ?.copyWith(fontSize: 14, fontWeight: FontWeight.w500),
                  )
                ],
              )),
            ],
          ),
        ],
      ),
    );
  }
}
