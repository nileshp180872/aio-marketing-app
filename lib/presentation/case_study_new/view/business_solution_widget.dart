import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../model/business_challenge.dart';
import 'business_solution_single_tile_widget.dart';

class BusinessSolutionWidget extends StatelessWidget {
  List<BusinessChallenge> businessSolution;

  BusinessSolutionWidget({required this.businessSolution, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 50),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SectionHeaderWidget(
            title: AppStrings.businessSolutions,
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
              height: 400,
              width: double.infinity,
              child: _buildBusinessSolution()),
        ],
      ),
    );
  }

  /// Build business solution list
  Widget _buildBusinessSolution() {
    return ListView.separated(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return BusinessSolutionSingleTileWidget(
              model: businessSolution[index]);
        },
        separatorBuilder: (_, __) {
          return SizedBox(
            width: 20,
          );
        },
        itemCount: businessSolution.length);
  }
}
