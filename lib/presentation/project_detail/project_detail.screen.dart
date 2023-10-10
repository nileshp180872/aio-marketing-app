import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/presentation/project_detail/view/project_image_tile_widget.dart';
import 'package:aio/presentation/project_detail/view/project_image_widget.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
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
            splashFactory: NoSplash.splashFactory,
            highlightColor: Colors.transparent,
            onTap:
                _controller.enableNext.isTrue ? _controller.goToNextPage : null,
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
          _buildContentText(content: _controller.technologies.value ?? ""),
          const SizedBox(
            height: 38,
          ),
          _buildSectionHeader(title: AppStrings.domain),
          _buildContentText(
              content: _controller.projectData.value.overView ?? ""),
          const SizedBox(
            height: 38,
          ),
          _buildSectionHeader(title: AppStrings.description),
          _buildLinkableText(
              content: _controller.projectData.value.description ?? ""),
               const SizedBox(
            height: 38,
          ),
          _buildSectionHeader(title: AppStrings.liveLink),
          _buildLinkableText(
              content: _controller.projectData.value.urlLink ?? ""),
         
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

  Widget _buildLinkableText({required String content}) {
    return Linkify(
      onOpen: (link) => _controller.onLinkClick(link),
      text: content,
      style: _textTheme.bodyMedium,
    );
  }

  /// Build project image list
  Widget _buildProjectImagesList() {
    final screenSize = MediaQuery.of(_buildContext).size.width;
    final leftContainerSize = screenSize - 90;
    final remainingLeftContainerSize = leftContainerSize / 2;
    final listItemWidth = remainingLeftContainerSize - 72;
    final finalListItemWidth = (listItemWidth / 3);
    return SizedBox(
      height: 100,
      child: IntrinsicHeight(
        child: Obx(
          () => ListView.separated(
              scrollDirection: Axis.horizontal,
              itemBuilder: (_, index) {
                return ProjectImageTileWidget(
                  itemWidth: finalListItemWidth,
                  index: index,
                  selectImage: _controller.onSelectImage,
                  imagePath: _controller.listImages[index],
                );
              },
              separatorBuilder: (_, index) {
                return Container(
                  width: 30,
                );
              },
              itemCount: _controller.listImages.length),
        ),
      ),
    );
  }

  /// Build image preview.
  Widget _buildImagePreview() {
    return ProjectImageWidget(
      imageURL: _controller.activeImage.value,
      fit: BoxFit.fill,
    );
  }
}
