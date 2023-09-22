import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import '../../../config/app_assets.dart';
import '../../../config/app_colors.dart';
import '../../../config/app_constants.dart';
import '../../../config/app_strings.dart';

class SuccessDialogWidget extends StatelessWidget {
  String contentText;

  late TextTheme _textTheme;
  Function onSubmit;

  SuccessDialogWidget(
      {required this.contentText, required this.onSubmit, super.key});

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Material(
      color: Colors.transparent,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(4)),
          padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 70),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildSuccessAnimationWidget(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 20.0, horizontal: 20),
                child: Column(
                  children: [
                    Text(
                      AppStrings.success,
                      style: _textTheme.labelMedium?.copyWith(
                          fontSize: 34, color: AppColors.colorSecondary),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      contentText,
                      style: _textTheme.bodyMedium?.copyWith(fontSize: 18),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              _buildDoneButton()
            ],
          ),
        ),
      ),
    );
  }

  /// Build done button
  Widget _buildDoneButton() {
    return InkWell(
      onTap: () => onSubmit(),
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 44),
          decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            AppStrings.goToHome,
            style: _textTheme.labelLarge
                ?.copyWith(fontFamily: AppConstants.poppins),
          )),
    );
  }

  /// Build success animation.
  Widget _buildSuccessAnimationWidget() {
    return Lottie.asset(LottieAssets.successAnimation, repeat: false);
  }
}
