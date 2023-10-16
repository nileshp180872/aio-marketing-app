import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../../project_detail/view/project_image_widget.dart';
import '../controllers/single_case_study_item_controller.dart';
import 'bottom_section.dart';
import 'business_challange_widget.dart';
import 'business_solution_widget.dart';
import 'company_overview_widget.dart';
import 'conclution_section.dart';

class CaseStudySingleItemWidget extends StatefulWidget {
  int index;

  CaseStudySingleItemWidget({required this.index, super.key});

  @override
  State<CaseStudySingleItemWidget> createState() =>
      _CaseStudySingleItemWidgetState();
}

class _CaseStudySingleItemWidgetState extends State<CaseStudySingleItemWidget> {
  late TextTheme _textTheme;

  late SingleCaseStudyItemController _controller;

  @override
  void initState() {
    _controller = Get.find<SingleCaseStudyItemController>(
        tag: "casestudy_${widget.index}");

    _controller.preparePortfolioData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Obx(
      () => SingleChildScrollView(
        controller: _controller.scrollController,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildHeaderMainSection(),
            CompanyOverviewWidget(
              companyTitle: _controller.projectData.value.companyName ?? "",
              companyDescription:
                  _controller.projectData.value.companyDescription ?? "",
              companyImage: _controller.projectData.value.companyImage ?? "",
            ),
            BusinessChallenges(
                businessChallenges: _controller.businessChallenges),
            BusinessSolutionWidget(
              businessSolution: _controller.businessSolution,
            ),
            BottomSection(
              sliderImage: _controller.businessImages,
              techlogoImage: _controller.techLogo,
            ),
            ConclutionSection(
                conclusion: _controller.projectData.value.conclusion ?? ""),
          ],
        ),
      ),
    );
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
                  _controller.projectData.value.projectName ?? "",
                  style: _textTheme.headlineLarge
                      ?.copyWith(fontSize: 50, color: Colors.white),
                ),
                const SizedBox(
                  height: 10,
                ),
                _buildHeaderSection(
                    title: AppStrings.platform,
                    children: (_controller.projectData.value.technologies ?? "")
                        .split(",")),
                const SizedBox(
                  height: 20,
                ),
                _buildHeaderSection(
                    title: AppStrings.industry,
                    children: [_controller.projectData.value.domainName ?? ""]),
              ],
            ),
          ),
          Expanded(
            flex: 4,
            child: ProjectImageWidget(
                imageURL:
                    _controller.projectData.value.casestudyBannerImage ?? ""),
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
        if (children.isNotEmpty)
          SizedBox(
            child: Wrap(
              children:
                  children.map((e) => buildHeaderButton(title: e)).toList(),
            ),
          ),
      ],
    );
  }

  Widget buildHeaderButton({required String title}) {
    return Container(
      margin: const EdgeInsets.only(right: 8, top: 8),
      color: AppColors.colorPrimary,
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 13),
      child: Text(
        title,
        style: _textTheme.displaySmall
            ?.copyWith(fontSize: 20, color: Colors.white),
      ),
    );
  }
}
