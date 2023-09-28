import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_values.dart';
import '../model/member_model.dart';

class MemberTileWidget extends StatelessWidget {
  MemberTileWidget({required this.memberModel, super.key});

  final MemberModel memberModel;
  late TextTheme _textTheme;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    _textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(child: _buildLeftContainer()),
        const SizedBox(
          width: 30,
        ),
        Expanded(child: _buildRightContainer()),
      ],
    );
  }

  /// Build left container
  Widget _buildLeftContainer() {
    return Container(
      height: AppValues.memberHeight,
      width: double.infinity,
      color: AppColors.colorSecondary.withOpacity(0.15),
      padding: const EdgeInsets.only(top: 44, left: 40, right: 40),
      child: Image.asset(
        'assets/images/team_image.png',
        fit: BoxFit.fitHeight,
      ),
    );
  }

  /// Widget build right container.
  Widget _buildRightContainer() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMemberNameText(title: memberModel.memberName??""),
          const SizedBox(
            height: 4,
          ),
          _buildDesignationText(title: memberModel.position??""),
          const SizedBox(
            height: 24,
          ),
          _buildContentText(
              content:memberModel.introduction??""),
        ],
      ),
    );
  }

  /// Build member name title.
  Widget _buildMemberNameText({required String title}) {
    return Text(
      title.toUpperCase(),
      style: _textTheme.headlineMedium?.copyWith(
          fontWeight: FontWeight.w700,
          fontSize: 40,
          color: AppColors.colorSecondary),
    );
  }

  /// Build designation title.
  Widget _buildDesignationText({required String title}) {
    return Text(
      title,
      style: _textTheme.headlineSmall?.copyWith(
          color: AppColors.colorPrimary,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.3),
    );
  }

  /// Build section title.
  Widget _buildContentText({required String content}) {
    return Text(
      content,
      style: _textTheme.bodyMedium,
    );
  }
}
