import 'package:aio/presentation/case_study_new/view/section_header_widget.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.only(top: 20, bottom: 20, left: 80, right: 60),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 40,
          ),
          SectionHeaderWidget(
            title: AppStrings.businessSolutions,
          ),
          const SizedBox(
            height: 20,
          ),
          _buildFeaturedCards(businessSolution),
        ],
      ),
    );
  }

  Widget _buildFeaturedCards(List<BusinessChallenge> product) {
    final cards = <Widget>[];
    Widget FeautredCards;

    if (product.length > 0) {
      for (int i = 0; i < product.length; i++) {
        cards.add(BusinessSolutionSingleTileWidget(model: businessSolution[i]));
        print(product.length);
      }
      FeautredCards = Container(
        padding: EdgeInsets.only(top: 16, bottom: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: cards),
            ),
          ],
        ),
      );
    } else {
      FeautredCards = Container();
    }
    return FeautredCards;
  }

  /// Build business solution list
  Widget _buildBusinessSolution() {
    return ListView.separated(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (_, index) {
          return BusinessSolutionSingleTileWidget(
              model: businessSolution[index]);
        },
        separatorBuilder: (_, __) {
          return const SizedBox(
            width: 20,
          );
        },
        itemCount: businessSolution.length);
  }
}
