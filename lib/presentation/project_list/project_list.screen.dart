import 'package:aio/presentation/project_list/view/pagination_project_grid_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../config/app_values.dart';
import '../../infrastructure/navigation/routes.dart';
import 'controllers/project_list.controller.dart';

class ProjectListScreen extends GetView<ProjectListController> with AppFeature {
  final ProjectListController _controller = Get.find(tag: Routes.PROJECT_LIST);

  ProjectListScreen({Key? key}) : super(key: key);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomAppBarWithDropdown(
                  title: _controller.screenTitle.value,
                  screenValue: _controller.screenTitle.value,
                  filterApplied: _controller.filterApplied.isTrue,
                  onClick: _controller.onFilterClick),
              Expanded(child: _buildScreenBody())
            ],
          ),
        ),
      ),
    );
  }

  /// build screen body
  Widget _buildScreenBody() {
    return PaginationProjectGridWidget(
      pagingController: _controller.pagingController,
      isLoading: _controller.isLoading,
      onClick: _controller.onProjectClick,
    ).marginOnly(right: AppValues.sideMargin, left: AppValues.sideMargin);
  }
}
