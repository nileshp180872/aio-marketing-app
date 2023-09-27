import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/project_list/view/project_list_widget.dart';
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
    return Container(
      margin: const EdgeInsets.symmetric(
          horizontal: AppValues.sideMargin, vertical: 34),
      child: ProjectListWidget(
        projectList: _controller.projectList,
        isLoading: _controller.isLoading,
        onClick: _controller.onProjectClick,
      ),
    );
  }

  /// Build project list header widget.
  Widget _buildProjectListHeader() {
    return Container(
      color: AppColors.headerBackground,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
      child: Text(
        AppStrings.project.toUpperCase(),
        style: _textTheme.titleSmall?.copyWith(
          letterSpacing: 1.0,
        ),
      ),
    );
  }

  /// Build list title container
  Widget buildListTitleContainer() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppValues.size_10),
      color: AppColors.colorPrimary,
    );
  }
}
