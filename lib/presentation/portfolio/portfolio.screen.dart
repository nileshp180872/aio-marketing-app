import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../infrastructure/navigation/routes.dart';
import 'controllers/portfolio.controller.dart';

class PortfolioScreen extends GetView<PortfolioController> with AppFeature {
  final PortfolioController _controller =
      Get.find<PortfolioController>(tag: Routes.PORTFOLIO);

  late BuildContext _buildContext;

  PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    return Scaffold(
      body: SafeArea(
        child: Obx(
          () => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildCustomAppBar(title: _controller.screenTitle.value),
              _buildScreenBody()
            ],
          ),
        ),
      ),
    );
  }

  /// build screen body
  Widget _buildScreenBody() {
    return Container(
      margin: const EdgeInsets.all(AppValues.sideMargin),
      child: Row(
        children: [
          Expanded(child: _buildLeftSideContainer()),
          Expanded(child: Container())
        ],
      ),
    );
  }

  /// Build domain dropdown.
  Widget _buildDomainDropdown() {
    return buildBaseDropdown(
        title: 'Select Domains',
        items: _controller.lstDomains,
        selectedItem: _controller.selectedDomains.value,
        onChangeSelection: _controller.setDomain);
  }

  /// Build left side container area.
  Widget _buildLeftSideContainer() {
    return Column(
      children: [
        _buildDomainDropdown(),
        const SizedBox(
          height: AppValues.size_20,
        ),
        if (_controller.portfolioEnum != PortfolioEnum.CASE_STUDY)
          _buildMobileWeb(),
        if (_controller.portfolioEnum != PortfolioEnum.CASE_STUDY)
          const SizedBox(
            height: AppValues.size_20,
          ),
        _buildTechnologyStack()
      ],
    );
  }

  /// Build mobile/web dropdown.
  Widget _buildMobileWeb() {
    return buildBaseDropdown(
        title: 'Select Domains',
        items: _controller.lstMobileWeb,
        selectedItem: _controller.selectedMobileWeb.value,
        onChangeSelection: _controller.setMobileWeb);
  }

  /// Build technology stack dropdown.
  Widget _buildTechnologyStack() {
    return buildBaseDropdown(
        title: 'Select Domains',
        items: _controller.lstTechnologies,
        selectedItem: _controller.selectedTechnologies.value,
        onChangeSelection: _controller.setTechnology);
  }
}
