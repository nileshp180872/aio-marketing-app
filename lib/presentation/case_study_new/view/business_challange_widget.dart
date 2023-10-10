import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_strings.dart';

class BusinessChallenges extends StatelessWidget {
  const BusinessChallenges({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Row(
        children: [
          Expanded(flex: 4, child: Container()),
          Expanded(
            flex: 6,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionHeaderWidget(
                  title: AppStrings.businessChallenges,
                ),
                SizedBox(
                  height: 4,
                ),
                _buildBusinessChallengeList(),
              ],
            ),
          ),
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
          return Container(
            child: Row(
              children: [
                Container(
                  height: 100,
                  width: 100,
                  color: Colors.red,
                ),
                Expanded(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("asdsad"),
                    Text("asdsad"),
                  ],
                ))
              ],
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const Divider(
            height: 4,
            color: Colors.transparent,
          );
        },
        itemCount: 3);
  }
}
