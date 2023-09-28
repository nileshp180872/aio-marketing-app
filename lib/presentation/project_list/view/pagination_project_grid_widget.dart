import 'package:aio/presentation/project_list/model/project_list_model.dart';
import 'package:aio/presentation/project_list/view/project_list_grid_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

class PaginationProjectGridWidget extends StatelessWidget {
  PagingController<int, ProjectListModel> pagingController;
  bool isLoading;
  Function(ProjectListModel model, int index) onClick;

  PaginationProjectGridWidget(
      {required this.pagingController,
      this.isLoading = false,
      required this.onClick,
      super.key});

  @override
  Widget build(BuildContext context) {
    return isLoading ? _buildLoadingIndicator() : _buildPagedGridView();
  }

  /// Build paged grid view.
  Widget _buildPagedGridView() {
    return PagedGridView<int, ProjectListModel>(
      pagingController: pagingController,
      builderDelegate: PagedChildBuilderDelegate<ProjectListModel>(
        itemBuilder: (context, item, index) => ProjectListGridTileWidget(
          projectListModel: item,
          onClick: onClick,
          index: index,
        ),
        noItemsFoundIndicatorBuilder: (_) => _buildNoDataWidget(),
        firstPageProgressIndicatorBuilder: (_) => _buildLoadingIndicator(),
        newPageProgressIndicatorBuilder: (_) => _buildLoadingIndicator(),
      ),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          crossAxisSpacing: 30,
          mainAxisSpacing: 30,
          childAspectRatio: 1.1),
    );
  }

  /// Build loading indicator
  Widget _buildLoadingIndicator() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  /// Build no data widget
  Widget _buildNoDataWidget() {
    return Container(
      child: Text("No data Found"),
    );
  }
}
