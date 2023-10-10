import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../config/app_colors.dart';
import '../../../config/app_constants.dart';
import '../../../config/app_strings.dart';
import '../../../utils/utils.dart';

class ShareDocDialog extends StatelessWidget {
  // Form Key
  final GlobalKey<FormState> enquiryFormKey = GlobalKey<FormState>();

  Function(String email) onShareClick;
  String _email = "";
  TextEditingController emailController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();

  ShareDocDialog({required this.onShareClick, super.key});

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    final screenWidth = MediaQuery.of(context).size.width;
    return Center(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: screenWidth * 0.5,
        padding: const EdgeInsets.all(20),
        child: Stack(
          children: [
            Form(
              key: enquiryFormKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  const Row(
                    children: [
                      Text(
                        AppStrings.inputString,
                        textAlign: TextAlign.start,
                        style: TextStyle(
                           fontSize: 22
                        ),
                      ),
                    ],
                  ),
                  _buildEmailField(),
                  const SizedBox(
                    height: 40,
                  ),
                  _buildEnquiryButton()
                ],
              ),
            ),
            Positioned(
                right: 0,
                child: IconButton(
                  onPressed: (){
                    Get.back();
                  },
                  icon: const Icon(Icons.close),
                ),),
          ],
        ),
      ),
    );
  }

  /// Build email text field.
  Widget _buildEmailField() {
    return Utils.buildBaseTextField(
        controller: emailController,
        label: AppStrings.emailMandatory,
        isEmail: true,
        onChange: _setEmail,
        focusNode: emailFocusNode,
        onValidate: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.emailValidationMsg;
          } else if (!(value ?? "").isEmail) {
            return AppStrings.emailNotValid;
          } else {
            return null;
          }
        });
  }

  /// set email
  void _setEmail(String value) {
    _email = value;
  }

  /// Build submit button.
  void submit() {
    if (enquiryFormKey.currentState!.validate()) {
      Get.back();
      onShareClick(_email);
    }
  }

  /// Build enquiry button
  Widget _buildEnquiryButton() {
    return InkWell(
      onTap: submit,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 36),
        decoration: BoxDecoration(
            color: AppColors.colorPrimary,
            borderRadius: BorderRadius.circular(4)),
        child: Text(
          AppStrings.submit,
          style:
              _textTheme.labelLarge?.copyWith(fontFamily: AppConstants.poppins),
        ),
      ),
    );
  }
}
