import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../infrastructure/navigation/routes.dart';

mixin AppFeature {
  AppBar buildAppBarWithSearch() {
    return AppBar(
      toolbarHeight: 70,
      elevation: 0,
      backgroundColor: Colors.white,
      title: _buildLeftLogo(),
      centerTitle: false,
      actions: [_buildSearchContainer()],
    );
  }

  /// Build custom appbar
  ///
  Widget buildCustomAppBarWithoutTite({ bool enableSearch=false}) {
    return buildCustomAppBarWithoutChild(enableSearch: enableSearch);
  }

  /// Build custom appbar
  ///
  /// required[title] for title text
  Widget buildCustomAppBar({String title = "", bool enableSearch=true}) {
    return buildCustomAppBarWithChild(child: _buildTitleWithBack(title: title, ),enableSearch: enableSearch);
  }

  /// Build appbar widget with custom child below custom view.
  ///
  /// required [child] widget which needs to add below appbar.
  Widget buildCustomAppBarWithoutChild(
      { bool enableSearch = true}) {
    return Container(
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
                    Get.until((route) => route.settings.name == Routes.HOME);
                  },
                  child: SvgPicture.asset(SVGAssets.headerAppLogo,height: 50,)),
              const Spacer(),
              if (enableSearch) _buildSearchContainer()
            ]),
          ),
          Container(height: 30,)
        ],
      ),
    );
  }

  /// Build appbar widget with custom child below custom view.
  ///
  /// required [child] widget which needs to add below appbar.
  Widget buildCustomAppBarWithChild(
      {required Widget child, bool enableSearch = true}) {
    return Container(
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
                    Get.until((route) => route.settings.name == Routes.HOME);
                  },
                  child: SvgPicture.asset(SVGAssets.headerAppLogo)),
              const Spacer(),
              if (enableSearch) _buildSearchContainer()
            ]),
          ),
          child
        ],
      ),
    );
  }

  /// Build appbar widget with custom child below custom view.
  ///
  /// required [child] widget which needs to add below appbar.
  Widget buildCustomAppBarWithDropdown(
      {required String title,
      required String screenValue,
      bool filterApplied = false,
      required Function() onClick,
      bool enableSearch = true}) {
    return Container(
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
                    Get.until((route) => route.settings.name == Routes.HOME);
                  },
                  child: SvgPicture.asset(SVGAssets.headerAppLogo)),
              const Spacer(),
              if (enableSearch) _buildSearchContainer()
            ]),
          ),
          Row(
            children: [
              _buildTitleWithBack(title: title),
              const Spacer(),
              InkWell(
                onTap: () => onClick(),
                child: Container(
                  height: 36,
                  width: 200,
                  child: Container(
                    height: 36,
                    width: 200,
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                           Radius.circular(8.0),
                        ),
                        border: Border.all(
                            color: AppColors.colorSecondary.withOpacity(0.5))),
                    margin: const EdgeInsets.only(right: AppValues.sideMargin),
                    child: Stack(
                      children: [
                        Center(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Text(
                                    screenValue,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  )),
                              Icon(
                                Icons.arrow_drop_down_outlined,
                                color:
                                    AppColors.colorSecondary.withOpacity(0.5),
                              )
                            ],
                          ),
                        ),
                        if (filterApplied)
                          Align(
                            alignment: Alignment.centerRight,
                            child: Container(
                              height: 10,
                              width: 10,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.red,
                              ),
                            ),
                          )
                      ],
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  /// Build appbar widget with custom child below custom view.
  ///
  /// required [child] widget which needs to add below appbar.
  Widget buildCustomAppBarWithFilter(
      {required Widget child, bool enableSearch = true}) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0),
          end: Alignment(0, 1),
          colors: [Color(0xFFDEF8FF), Color(0xFFFFFFFF)],
        ),
      ),
      padding: const EdgeInsets.only(
          left: AppValues.sideMargin, right: AppValues.sideMargin),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                  onTap: () {
                    Get.until((route) => route.settings.name == Routes.HOME);
                  },
                  child: SvgPicture.asset(SVGAssets.headerAppLogo)),
              _buildTitleWithBack(title: "This")
            ],
          ),
          Spacer(),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (enableSearch) _buildSearchContainer(ignoreRightMargin: true),
              child
            ],
          ),
        ],
      ),
    );
  }

  /// Build left logo.
  Widget _buildLeftLogo() {
    return InkWell(
      onTap: () {
        Get.until((route) => route.settings.name == Routes.HOME);
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 28.0),
        child: SvgPicture.asset(SVGAssets.headerAppLogo),
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
                ),),
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

  Widget _buildDummyDropdownContainer(
      {required Function() onClick,
      String displayText = "",
      bool ignoreRightMargin = false}) {
    return InkWell(
      onTap: () => onClick(),
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
                      color: AppColors.colorSecondary.withOpacity(0.25))),
              child: Row(
                children: [
                  const SizedBox(
                    width: AppValues.size_10,
                  ),
                  Expanded(
                    child: Text(
                      displayText,
                      style: TextStyle(
                          color: AppColors.colorSecondary.withOpacity(0.75),
                          fontSize: 14,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  SvgPicture.asset(SVGAssets.backIcon),
                  const SizedBox(
                    width: AppValues.size_10,
                  ),
                ],
              )),
        ),
      ),
    );
  }

  /// Build title with back
  Widget _buildTitleWithBack({required String title}) {
    return InkWell(
      onTap: () {
        Get.back();
      },
      child: Row(
        children: [
          SvgPicture.asset(SVGAssets.backIcon),
          const SizedBox(
            width: 24,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                width: MediaQuery.of(Get.context!).size.width * 0.9,
                child: Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: const TextStyle(
                      color: AppColors.colorSecondary,
                      fontSize: 32,
                      fontWeight: FontWeight.w700),
                ),
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
          )
        ],
      ),
    );
  }

  Widget buildBaseDropdown(
      {required String title,
      required List<String> items,
      required String selectedItem,
      required Function(String? selectedValue) onChangeSelection}) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        enableFeedback: true,
        items: items
            .map((String item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    maxLines: 1,
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.colorSecondary.withOpacity(0.5),
                        fontFamily: AppConstants.sourceSansPro),
                    overflow: TextOverflow.ellipsis,
                  ),
                ))
            .toList(),
        selectedItemBuilder: (context) {
          return items.map(
            (item) {
              return Container(
                alignment: AlignmentDirectional.centerStart,
                child: Text(
                  item,
                  style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.colorSecondary,
                      fontFamily: AppConstants.sourceSansPro),
                  maxLines: 1,
                ),
              );
            },
          ).toList();
        },
        value: selectedItem,
        style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.colorSecondary,
            fontFamily: AppConstants.sourceSansPro),
        buttonStyleData: ButtonStyleData(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: Colors.black26,
            ),
            color: Colors.white,
          ),
          elevation: 0,
        ),
        onChanged: (String? value) {
          onChangeSelection(value);
        },
      ),
    );
  }
}
