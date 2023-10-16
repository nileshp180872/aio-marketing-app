import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/presentation/case_study_new/view/case_study_single_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../utils/user_feature.mixin.dart';
import 'controllers/case_study_new.controller.dart';
import 'controllers/single_case_study_item_controller.dart';

class CaseStudyNewScreen extends GetView<CaseStudyNewController>
    with AppFeature {
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
                  _buildPagedView(),
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
    );
  }

  /// Build case study paged view
  Widget _buildPagedView() {
    return PageView.builder(
        controller: _controller.pageController,
        itemCount: _controller.projectList.length,
        onPageChanged: _controller.onPageChange,
        itemBuilder: (_, index) {
          Get.lazyPut<SingleCaseStudyItemController>(
              () => SingleCaseStudyItemController(),
              tag: "casestudy_${index}");

          SingleCaseStudyItemController ctrl =
              Get.find(tag: "casestudy_${index}");
          ctrl.projectData.value = _controller.projectList[index];
          ctrl.listImages.value = _controller.listImages;
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: CaseStudySingleItemWidget(index: index),
          );
        });
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
