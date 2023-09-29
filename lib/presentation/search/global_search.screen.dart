import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/presentation/project_list/view/pagination_project_grid_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../config/app_assets.dart';
import '../../config/app_colors.dart';
import '../../config/app_constants.dart';
import '../../infrastructure/navigation/routes.dart';
import 'controllers/global_search.controller.dart';

class GlobalSearchScreen extends GetView<GlobalSearchController>
    with AppFeature {
  GlobalSearchScreen({Key? key}) : super(key: key);

  final GlobalSearchController _controller = Get.find(tag: Routes.SEARCH);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          buildCustomAppBarWithChild(
              child: _buildHeaderRow(), enableSearch: false),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppValues.sideMargin,
                  vertical: AppValues.size_30),
              child: PaginationProjectGridWidget(
                pagingController: _controller.pagingController,
                onClick: _controller.onProjectClick,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Build header row widget.
  Widget _buildHeaderRow() {
    return Row(
      children: [
        InkWell(
          onTap: () => Get.back(),
          child: Padding(
            padding: const EdgeInsets.only(right: AppValues.size_24),
            child: SvgPicture.asset(SVGAssets.backIcon),
          ),
        ),
        Expanded(child: _buildSearchTextField()),
        const SizedBox(
          width: AppValues.sideMargin,
        ),
      ],
    );
  }

  /// Build search field.
  Widget _buildSearchTextField() {
    const textStyle = TextStyle(
        color: AppColors.colorSecondary,
        fontSize: 24,
        fontFamily: AppConstants.sourceSansPro);
    return TextFormField(
      controller: _controller.searchController,
      focusNode: _controller.searchFocusNode,
      onTapOutside: (_) {
        _controller.searchFocusNode.unfocus();
      },
      onChanged: _controller.setSearch,
      keyboardType: TextInputType.text,
      style: textStyle,
      maxLines: 1,
      enableSuggestions: true,
      textInputAction: TextInputAction.search,
      onFieldSubmitted: (_) {},
      decoration: InputDecoration(
        hintText: AppStrings.searchInputText,
        alignLabelWithHint: true,
        counter: Container(),
        hintStyle: textStyle,
      ),
    );
  }
}
