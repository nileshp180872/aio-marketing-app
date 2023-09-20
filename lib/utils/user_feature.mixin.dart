import 'dart:math' as math;

import 'package:aio/config/app_assets.dart';
import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
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

  Widget buildCustomAppBar({String title = ""}) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(-1.0, 0.0),
          end: Alignment(1.0, 0.0),
          transform: GradientRotation(math.pi / 2),
          colors: [Color(0xFFDEF8FF), Color(0xFFFFFFFF)],
        ),
      ),
      padding: const EdgeInsets.only(left: AppValues.sideMargin),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: double.infinity,
            height: 77,
            child: Row(children: [
              SvgPicture.asset(SVGAssets.headerAppLogo),
              const Spacer(),
              _buildSearchContainer()
            ]),
          ),
          _buildTitleWithBack(title: title)
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
}
