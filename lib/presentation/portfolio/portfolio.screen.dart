import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import 'controllers/portfolio.controller.dart';

class PortfolioScreen extends GetView<PortfolioController> with AppFeature {
  final PortfolioController _controller =
      Get.find<PortfolioController>(tag: Routes.PORTFOLIO);

  PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildCustomAppBar(title: AppStrings.workPortfolio),
            _buildScreenBody()
          ],
        ),
      ),
    );
  }

  /// build screen body
  Widget _buildScreenBody() {
    return Container(
      margin: EdgeInsets.all(AppValues.sideMargin),
    );
  }
}
