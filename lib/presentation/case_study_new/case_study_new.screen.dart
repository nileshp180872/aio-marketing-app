import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/case_study_new/view/business_challange_widget.dart';
import 'package:aio/presentation/case_study_new/view/business_solution_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../utils/user_feature.mixin.dart';
import 'controllers/case_study_new.controller.dart';
import 'view/company_overview_widget.dart';

class CaseStudyNewScreen extends GetView<CaseStudyNewController> with AppFeature {
  CaseStudyNewScreen({Key? key}) : super(key: key);
  CaseStudyNewController _controller = Get.find(tag: Routes.CASE_STUDY_NEW);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              buildCustomAppBar(title: AppStrings.caseStudy),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildHeaderMainSection(),
                      CompanyOverviewWidget(),
                      BusinessChallenges(
                          businessChallenges: _controller.businessChallenges),
                      BusinessSolutionWidget(
                        businessSolution: _controller.businessSolution,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildHeaderMainSection() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.colorSecondary,
        image: DecorationImage(
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.05), BlendMode.dstATop),
          image: const AssetImage(AppAssets.caseStudyHeaderBackground),
        ),
      ),
      height: 700,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 40),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  AppStrings.caseStudy,
                  style: _textTheme.displaySmall
                      ?.copyWith(fontSize: 20, color: AppColors.colorPrimary),
                ),
                Text(
                  AppStrings.caseStudyHeaderMessage,
                  style: _textTheme.headlineLarge
                      ?.copyWith(fontSize: 50, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildHeaderSection(
                    title: AppStrings.platform, children: ["Web", "Mobile"]),
                const SizedBox(
                  height: 20,
                ),
                _buildHeaderSection(
                    title: AppStrings.industry, children: ["Energy"]),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: Image.asset(AppAssets.caseStudyHeaderSideImage),
          )
        ],
      ),
    );
  }

  Widget _buildHeaderSection(
      {required String title, required List<String> children}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: _textTheme.displaySmall
              ?.copyWith(fontSize: 20, color: Colors.white),
        ),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 56,
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: children.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return buildHeaderButton(title: children[index]);
              }),
        ),
      ],
    );
  }

  Widget buildHeaderButton({required String title}) {
    return Container(
      margin: const EdgeInsets.only(right: 10, top: 4),
      color: AppColors.colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
      child: Text(
        title,
        style: _textTheme.displaySmall
            ?.copyWith(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _buildBusinessChallenges() {
    return Container(
      color: AppColors.headerBackground,
      height: 300,
      width: double.infinity,
    );
  }

  Widget _buildBusinessSolution() {
    return Container(
      color: AppColors.headerBackground,
      height: 300,
      width: double.infinity,
    );
  }
}
