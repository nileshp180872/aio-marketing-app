import 'dart:math' as math;

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
      actions: [_buildSearchContainer()],
    );
  }

  /// Build custom appbar
  ///
  /// required[title] for title text
  Widget buildCustomAppBar({String title = ""}) {
    return buildCustomAppBarWithChild(child: _buildTitleWithBack(title: title));
  }

  /// Build appbar widget with custom child below custom view.
  ///
  /// required [child] widget which needs to add below appbar.
  Widget buildCustomAppBarWithChild({required Widget child, bool enableSearch=true}) {
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
              SvgPicture.asset(SVGAssets.headerAppLogo),
              const Spacer(),
              if(enableSearch)
              _buildSearchContainer()
            ]),
          ),
          child
        ],
      ),
    );
  }

  /// Build left logo.
  Widget _buildLeftLogo() {
    return Padding(
      padding: const EdgeInsets.only(left: 28.0),
      child: SvgPicture.asset(SVGAssets.headerAppLogo),
    );
  }

  Widget _buildSearchContainer() {
    return InkWell(
      onTap: () => Get.toNamed(Routes.SEARCH),
      child: Container(
        color: Colors.transparent,
        margin: const EdgeInsets.only(right: AppValues.sideMargin),
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
              Text(
                title,
                style: const TextStyle(
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
