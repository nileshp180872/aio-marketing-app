import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/presentation/case_study_new/view/bottom_section.dart';
import 'package:aio/presentation/case_study_new/view/business_challange_widget.dart';
import 'package:aio/presentation/case_study_new/view/business_solution_widget.dart';
import 'package:aio/presentation/case_study_new/view/conclution_section.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../utils/user_feature.mixin.dart';
import '../project_detail/view/project_image_widget.dart';
import 'controllers/case_study_new.controller.dart';
import 'view/company_overview_widget.dart';

class CaseStudyNewScreen extends GetView<CaseStudyNewController>
    with AppFeature {
  CaseStudyNewScreen({Key? key}) : super(key: key);
  CaseStudyNewController _controller = Get.find(tag: Routes.CASE_STUDY_NEW);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        body: Obx(
      () => SafeArea(
        child: Column(
          children: [
            // buildCustomAppBar(title: AppStrings.caseStudy),
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment(0, 0),
                  end: Alignment(0, 1),
                  colors: [Color(0xFFDEF8FF), Color(0xFFFFFFFF)],
                ),
              ),
              padding: const EdgeInsets.only(left: AppValues.sideMargin),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 77,
                    child: Row(children: [
                      GestureDetector(
                          onTap: () {
                            Get.until(
                                (route) => route.settings.name == Routes.HOME);
                          },
                          child: SvgPicture.asset(SVGAssets.headerAppLogo)),
                      const Spacer(),
                      if (true) _buildSearchContainer()
                    ]),
                  ),
                  InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            SvgPicture.asset(SVGAssets.backIcon),
                            const SizedBox(
                              width: 24,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  AppStrings.caseStudy,
                                  style: TextStyle(
                                      color: AppColors.colorSecondary,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  width: 50,
                                  height: 5,
                                  color: AppColors.colorPrimary,
                                )
                              ],
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 40.0),
                          child: IconButton(
                              onPressed: () async {
                                _controller.openGmail();
                              },
                              icon: const Icon(Icons.share,
                                  color: AppColors.colorSecondary)),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    controller: _controller.scrollController,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _buildHeaderMainSection(),
                        CompanyOverviewWidget(
                          companyTitle:
                              _controller.projectData.value.companyName ?? "",
                          companyDescription:
                              _controller.projectData.value.companyDescription ?? "",
                          companyImage:
                              _controller.projectData.value.companyImage ?? "",
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
                            conclusion:
                                _controller.projectData.value.conclusion ?? ""),
                      ],
                    ),
                  ),
                  Positioned(
                    top: 0,
                    bottom: 0,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: _controller.enablePrevious.isTrue
                          ? _controller.goToPreviousPage
                          : null,
                      child: SizedBox(
                          width: AppValues.sideMargin,
                          height: AppValues.sideMargin,
                          child: Center(
                              child: Icon(
                            Icons.arrow_back_ios_new,
                            color: _controller.enablePrevious.isTrue
                                ? AppColors.colorSecondary
                                : AppColors.colorSecondary.withOpacity(0.5),
                          ))),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      splashFactory: NoSplash.splashFactory,
                      highlightColor: Colors.transparent,
                      onTap: _controller.enableNext.isTrue
                          ? _controller.goToNextPage
                          : null,
                      child: SizedBox(
                          width: AppValues.sideMargin,
                          child: Center(
                              child: Icon(
                            Icons.arrow_forward_ios_rounded,
                            color: _controller.enableNext.isTrue
                                ? AppColors.colorSecondary
                                : AppColors.colorSecondary.withOpacity(0.5),
                          ))),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
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

  Widget _buildSearchContainer({bool ignoreRightMargin = false}) {
    return InkWell(
      onTap: () => Get.toNamed(Routes.SEARCH),
      child: Container(
        color: Colors.transparent,
        margin: EdgeInsets.only(
            right: ignoreRightMargin ? 0 : AppValues.sideMargin),
        child: Center(
          child: Container(
              width: 200,
              height: 32,
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: AppColors.colorSecondary.withOpacity(0.25),
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(8.0),
                ),
              ),
              child: Row(
                children: [
                  const SizedBox(
                    width: AppValues.size_10,
                  ),
                  Expanded(
                    child: Text(
                      AppStrings.searchInputText,
                      style: TextStyle(
                          color: AppColors.colorSecondary.withOpacity(0.75),
                          fontSize: 14),
                    ),
                  ),
                  SvgPicture.asset(SVGAssets.searchIcon),
                  const SizedBox(
                    width: AppValues.size_10,
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
