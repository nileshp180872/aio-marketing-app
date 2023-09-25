import 'package:aio/config/app_values.dart';
import 'package:aio/presentation/filter/view/filter_category_tile_widget.dart';
import 'package:aio/presentation/filter/view/filter_subcategory_grid_tile_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../config/app_strings.dart';
import '../../infrastructure/navigation/routes.dart';
import 'controllers/filter.controller.dart';

class FilterScreen extends GetView<FilterController> with AppFeature {
  FilterScreen({Key? key}) : super(key: key);
  FilterController _controller = Get.find(tag: Routes.FILTER);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
        floatingActionButton: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildClearButton(),
            const SizedBox(width: 20,),
            _buildApplyButton(),
          ],
        ),
        body: Column(
          children: [
            buildCustomAppBar(title: "Filter"),
            Expanded(child: Obx(() => _buildBodyWidget())),
          ],
        ));
  }

  Widget _buildBodyWidget() {
    return Padding(
      padding: const EdgeInsets.all(AppValues.sideMargin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildLeftSideList()),
          SizedBox(
            width: 30,
          ),
          Expanded(
            flex: 3,
            child: Container(child: _buildRightSliderList()),
          )
        ],
      ),
    );
  }

  /// Build left side slider
  Widget _buildLeftSideList() {
    return ListView.separated(
      itemBuilder: (_, index) {
        return FilterCategoryTileWidget(
          text: _controller.list1[index],
          isSelected: index == _controller.selectedIndex.value,
          index: index,
          onClick: _controller.setSelectedIndex,
        );
      },
      separatorBuilder: (_, index) {
        return Divider(
          height: 1,
          color: Colors.grey.withOpacity(0.5),
        );
      },
      itemCount: _controller.list1.length,
    );
  }

  /// Build right side slider
  Widget _buildRightSliderList() {
    switch (_controller.selectedIndex.value) {
      case 1:
        return _buildMobileList();
      case 2:
        return _buildTechnologyStackList();

      default:
        return _buildDomainList();
    }
  }

  /// Build domain list
  Widget _buildDomainList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3.0,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      itemBuilder: (_, index) {
        return FilterSubCategoryGridTileWidget(
            index: index,
            onTapItem: _controller.selectDomain,
            text: _controller.lstDomains[index]);
      },
      itemCount: _controller.lstDomains.length,
    );
  }

  /// Build mobile/web list
  Widget _buildMobileList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3.0,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      itemBuilder: (_, index) {
        return FilterSubCategoryGridTileWidget(
            index: index,
            onTapItem: _controller.selectMobileWeb,
            text: _controller.lstMobileWeb[index]);
      },
      itemCount: _controller.lstMobileWeb.length,
    );
  }

  /// Build technology stack list
  Widget _buildTechnologyStackList() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3.0,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20),
      itemBuilder: (_, index) {
        return FilterSubCategoryGridTileWidget(
            index: index,
            onTapItem: _controller.selectTechnology,
            text: _controller.lstTechnologies[index]);
      },
      itemCount: _controller.lstTechnologies.length,
    );
  }

  /// Build apply button
  Widget _buildApplyButton() {
    return InkWell(
      onTap: _controller.submit,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 42),
          decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            AppStrings.apply,
            style: _textTheme.labelLarge
                ?.copyWith(fontFamily: AppConstants.poppins),
          )),
    );
  }

  /// Build apply button
  Widget _buildClearButton() {
    return InkWell(
      onTap: _controller.onCancel,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 42),
          decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.2),
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            AppStrings.apply,
            style: _textTheme.labelLarge
                ?.copyWith(fontFamily: AppConstants.poppins, color: AppColors.textColorContent),
          )),
    );
  }
}
