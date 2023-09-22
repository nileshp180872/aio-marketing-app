import 'package:flutter/material.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_strings.dart';
import '../../../config/app_values.dart';

class MemberTileWidget extends StatelessWidget {
  MemberTileWidget({super.key});

  late TextTheme _textTheme;
  late BuildContext _buildContext;

  @override
  Widget build(BuildContext context) {
    _buildContext = context;
    _textTheme = Theme.of(context).textTheme;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
            width: AppValues.sideMargin,
            child: Center(child: Icon(Icons.arrow_back_ios_new))),
        Expanded(child: _buildLeftContainer()),
        const SizedBox(width: 30,),
        Expanded(child: _buildRightContainer()),
        const SizedBox(
            width: AppValues.sideMargin,
            child: Center(child: Icon(Icons.arrow_forward_ios_rounded))),
      ],
    );
  }

  /// Build left container
  Widget _buildLeftContainer() {
    return Container(
      height: AppValues.memberHeight,
      width: double.infinity,
      color: AppColors.colorSecondary.withOpacity(0.15),
      padding: const EdgeInsets.all(20),
      child: Image.asset('assets/images/sample_image.png'),
    );
  }

  /// Widget build right container.
  Widget _buildRightContainer() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildMemberNameText(title: "Ramesh Marand"),
          SizedBox(height: 4,),
          _buildDesignationText(title: "MD & CEO"),
          SizedBox(height: 24,),
          _buildContentText(
              content:
                  'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, to'),
        ],
      ),
    );
  }

  /// Build member name title.
  Widget _buildMemberNameText({required String title}) {
    return Text(
      title,
      style: _textTheme.headlineMedium,
    );
  }

  /// Build designation title.
  Widget _buildDesignationText({required String title}) {
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
}
