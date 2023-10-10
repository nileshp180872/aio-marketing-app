import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../model/business_challenge.dart';
import 'business_challenge_single_tile_widget.dart';

class BusinessChallenges extends StatelessWidget {
  List<BusinessChallenge> businessChallenges;

  BusinessChallenges({required this.businessChallenges, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.headerBackground,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 80),
      child: Row(
        children: [
          Expanded(
            flex: 5,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 40,
                ),
                SectionHeaderWidget(
                  title: AppStrings.businessChallenges,
                ),
                const SizedBox(
                  height: 20,
                ),
                _buildBusinessChallengeList(),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
          Expanded(flex: 4, child: Image.asset(AppAssets.caseStudyBusinessChallenges)),
        ],
      ),
    );
  }

  /// Build business challenge list
  Widget _buildBusinessChallengeList() {
    return ListView.separated(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemBuilder: (_, index) {
          return BusinessChallengeSingleTileWidget(
            model: businessChallenges[index],
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(
            height: 16,
            color: Colors.transparent,
          );
        },
        itemCount: businessChallenges.length);
  }
}
