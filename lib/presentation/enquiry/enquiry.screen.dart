import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/navigation/routes.dart';
import '../../utils/utils.dart';
import 'controllers/enquiry.controller.dart';

class EnquiryScreen extends GetView<EnquiryController> with AppFeature {
  EnquiryScreen({Key? key}) : super(key: key);

  EnquiryController _controller = Get.find(tag: Routes.ENQUIRY);

  late TextTheme _textTheme;

  @override
  Widget build(BuildContext context) {
    _textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: Column(
        children: [
          buildCustomAppBar(title: AppStrings.enquiryTitle),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  /// Build screen body.
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.all(AppValues.sideMargin),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildLeftContainer()),
          Expanded(child: Container())
        ],
      ),
    );
  }

  /// Build left container widget.
  Widget _buildLeftContainer() {
    return Form(
      key: _controller.enquiryFormKey,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildFullNameField(),
            _buildEmailField(),
            _buildPhoneNumberField(),
            _buildCompanyNameField(),
            _buildMessageField(),
            const SizedBox(
              height: 24,
            ),
            _buildEnquiryButton(),
          ],
        ),
      ),
    );
  }

  /// Build enquiry button
  Widget _buildEnquiryButton() {
    return InkWell(
      onTap: _controller.submit,
      child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
          decoration: BoxDecoration(
              color: AppColors.colorPrimary,
              borderRadius: BorderRadius.circular(4)),
          child: Text(
            AppStrings.submit,
            style: _textTheme.labelLarge
                ?.copyWith(fontFamily: AppConstants.poppins),
          )),
    );
  }

  /// Build full name text field.
  Widget _buildFullNameField() {
    return Utils.buildBaseTextField(
        controller: _controller.nameController,
        label: AppStrings.fullNameMandatory,
        onChange: _controller.setName,
        focusNode: _controller.nameFocusNode);
  }

  /// Build email text field.
  Widget _buildEmailField() {
    return Utils.buildBaseTextField(
        controller: _controller.emailController,
        label: AppStrings.emailMandatory,
        isEmail: true,
        onChange: _controller.setEmail,
        focusNode: _controller.emailFocusNode);
  }

  /// Build phone text field.
  Widget _buildPhoneNumberField() {
    return Utils.buildBaseTextField(
        controller: _controller.phoneNumberController,
        label: AppStrings.phoneMandatory,
        isPhoneNumber: true,
        onChange: _controller.setPhoneNumber,
        focusNode: _controller.phoneNumberFocusNode);
  }

  /// Build company name field.
  Widget _buildCompanyNameField() {
    return Utils.buildBaseTextField(
        controller: _controller.companyNameController,
        label: AppStrings.companyNameMandatory,
        onChange: _controller.setCompanyName,
        focusNode: _controller.companyNameFocusNode);
  }

  /// Build message field.
  Widget _buildMessageField() {
    return Utils.buildBaseTextField(
        controller: _controller.messageController,
        label: AppStrings.messageMandatory,
        isMultiline: true,
        onChange: _controller.setMessage,
        focusNode: _controller.messageFocusNode);
  }
}
