import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/project_detail/view/project_image_tile_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config/app_values.dart';
import '../../infrastructure/navigation/routes.dart';
import 'controllers/project_detail.controller.dart';

class ProjectDetailScreen extends GetView<ProjectDetailController>
    with AppFeature {

  ProjectDetailController _controller = Get.find(tag: Routes.PROJECT_DETAIL);

  ProjectDetailScreen({Key? key}) : super(key: key);

  late TextTheme _textTheme;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomAppBar(title: _controller.screenTitle.value),
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
      margin: const EdgeInsets.symmetric(vertical: AppValues.sideMargin),
      child: Row(
        children: [
          InkWell(
            onTap: _controller.goToPreviousPage,
            child: const SizedBox(
                width: AppValues.sideMargin,
                child: Center(child: Icon(Icons.arrow_back_ios_new))),
          ),
          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: _buildLeftSideProductImage()),
                const SizedBox(
                  width: 30,
                ),
                Expanded(child: _buildScrollableProductDetail())
              ],
            ),
          ),
          InkWell(
            onTap: _controller.goToNextPage,
            child: const SizedBox(
                width: AppValues.sideMargin,
                child: Center(child: Icon(Icons.arrow_forward_ios_rounded))),
          ),
        ],
      ),
    );
  }

  /// Build left side product image.
  Widget _buildLeftSideProductImage() {
    return Column(
      children: [
        Container(
            height: AppValues.projectDetailImagePreview,
            width: double.infinity,
            color: AppColors.colorSecondary.withOpacity(0.15),
            padding: const EdgeInsets.all(20),
            child: _buildImagePreview()),
        const SizedBox(
          height: 30,
        ),
        _buildProjectImagesList()
      ],
    );
  }

  /// Build scrollable product detail.
  Widget _buildScrollableProductDetail() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSectionHeader(title: AppStrings.usedTechnologies),
          _buildContentText(content: 'PHP, Angular JS, Figma'),
          const SizedBox(
            height: 38,
          ),
          _buildSectionHeader(title: AppStrings.overview),
          _buildContentText(content: 'PHP, Angular JS, Figma'),
          const SizedBox(
            height: 38,
          ),
          _buildSectionHeader(title: AppStrings.description),
          _buildContentText(
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to\n\n'
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con\n\n'
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to\n\n'
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con\n\n'
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to\n\n'
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con\n\n'
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to\n\n'
                  'Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo con\n\n'
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to\n\n'),
        ],
      ),
    );
  }

  /// Build section title.
  Widget _buildSectionHeader({required String title}) {
    return Text(
      title,
      style: _textTheme.headlineSmall,
    );
  }

  /// Build section title.
  Widget _buildContentText({required String content}) {
    return Text(
      content,
      style: _textTheme.bodyMedium,
    );
  }

  /// Build project image list
  Widget _buildProjectImagesList() {
    final screenSize = MediaQuery.of(_buildContext).size.width;
    final leftContainerSize = screenSize - 90;
    final remainingLeftContainerSize = leftContainerSize / 2;
    final listItemWidth = remainingLeftContainerSize - 63;
    final finalListItemWidth = (listItemWidth / 3);
    return SizedBox(
      height: 100,
      child: IntrinsicHeight(
        child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, index) {
              return ProjectImageTileWidget(
                itemWidth: finalListItemWidth,
              );
            },
            separatorBuilder: (_, index) {
              return Container(
                width: 30,
              );
            },
            itemCount: 3),
      ),
    );
  }

  /// Build image preview.
  Widget _buildImagePreview() {
    return Image.asset('assets/images/sample_image.png');
  }
}
