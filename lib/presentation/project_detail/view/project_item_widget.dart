import 'package:aio/presentation/project_detail/view/project_image_tile_widget.dart';
import 'package:aio/presentation/project_detail/view/project_image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../../../config/app_values.dart';
import '../controllers/project_item_controller.dart';

class ProjectItemWidget extends StatefulWidget {
  int index;

  ProjectItemWidget({required this.index, super.key});

  @override
  State<ProjectItemWidget> createState() => _ProjectItemWidgetState();
}

class _ProjectItemWidgetState extends State<ProjectItemWidget> {
  late ProjectItemController _controller;

  late BuildContext _buildContext;
  late TextTheme _textTheme;

  @override
  void initState() {
    _controller = Get.find<ProjectItemController>(tag: "item_${widget.index}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    _textTheme = Theme.of(context).textTheme;
    _controller.preparePortfolioData();
    return Obx(() => _buildItemRow());
  }

  Widget _buildItemRow() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildLeftSideProductImage()),
        const SizedBox(
          width: 30,
        ),
        Expanded(child: _buildScrollableProductDetail())
      ],
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
          if ((_controller.projectData.value.technologies ?? "").isNotEmpty)
            _buildSectionHeader(title: AppStrings.usedTechnologies),
          if ((_controller.projectData.value.technologies ?? "").isNotEmpty)
            _buildContentText(content: _controller.technologies.value ?? ""),
          const SizedBox(
            height: 38,
          ),
          if ((_controller.projectData.value.overView ?? "").isNotEmpty)
            _buildSectionHeader(title: AppStrings.domain),
          if ((_controller.projectData.value.overView ?? "").isNotEmpty)
            _buildContentText(
                content: _controller.projectData.value.overView ?? ""),
          const SizedBox(
            height: 38,
          ),
          if ((_controller.projectData.value.description ?? "").isNotEmpty)
            _buildSectionHeader(title: AppStrings.description),
          if ((_controller.projectData.value.description ?? "").isNotEmpty)
            _buildLinkableText(
                content: _controller.projectData.value.description ?? ""),
          const SizedBox(
            height: 38,
          ),
          if ((_controller.projectData.value.urlLink ?? "").isNotEmpty)
            _buildSectionHeader(title: AppStrings.liveLink),
          if ((_controller.projectData.value.urlLink ?? "").isNotEmpty)
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
      imageURL: _controller.projectData.value.networkImages!.elementAt(_controller.activeImageIndex.value),
      fit: BoxFit.fitHeight,
    );
  }
}
