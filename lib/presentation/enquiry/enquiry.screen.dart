import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:aio/config/app_strings.dart';
import 'package:aio/config/app_values.dart';
import 'package:aio/presentation/enquiry/model/country_model.dart';
import 'package:aio/utils/user_feature.mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
          buildCustomAppBar(
              title: AppStrings.enquiryTitle, enableSearch: false),
          Expanded(child: _buildBody()),
        ],
      ),
    );
  }

  /// Build screen body.
  Widget _buildBody() {
    return Padding(
      padding: const EdgeInsets.only(
        top: AppValues.sideMargin,
        right: AppValues.sideMargin,
        left: AppValues.sideMargin,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: _buildLeftContainer()),
          Expanded(
              child: _buildRightContainer().paddingSymmetric(horizontal: 12))
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
        focusNode: _controller.nameFocusNode,
        onValidate: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.nameValidationMsg;
          } else {
            return null;
          }
        });
  }

  /// Build email text field.
  Widget _buildEmailField() {
    return Utils.buildBaseTextField(
        controller: _controller.emailController,
        label: AppStrings.emailMandatory,
        isEmail: true,
        onChange: _controller.setEmail,
        focusNode: _controller.emailFocusNode,
        onValidate: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.emailValidationMsg;
          } else {
            return null;
          }
        });
  }

  /// Build phone text field.
  Widget _buildPhoneNumberField() {
    return Utils.buildBaseTextField(
        controller: _controller.phoneNumberController,
        label: AppStrings.phoneMandatory,
        isPhoneNumber: true,
        onChange: _controller.setPhoneNumber,
        focusNode: _controller.phoneNumberFocusNode,
        onValidate: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.phoneValidationMsg;
          } else {
            return null;
          }
        });
  }

  /// Build company name field.
  Widget _buildCompanyNameField() {
    return Utils.buildBaseTextField(
        controller: _controller.companyNameController,
        label: AppStrings.companyNameMandatory,
        onChange: _controller.setCompanyName,
        focusNode: _controller.companyNameFocusNode,
        onValidate: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.companyNameValidationMsg;
          } else {
            return null;
          }
        });
  }

  /// Build message field.
  Widget _buildMessageField() {
    return Utils.buildBaseTextField(
        controller: _controller.messageController,
        label: AppStrings.messageMandatory,
        isMultiline: true,
        onChange: _controller.setMessage,
        focusNode: _controller.messageFocusNode,
        onValidate: (value) {
          if (value == null || value.isEmpty) {
            return AppStrings.msgValidationMsg;
          } else {
            return null;
          }
        });
  }

  /// Build right container widget.
  Widget _buildRightContainer() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _mainCountryWidget(AppConstants.countryData),
          const SizedBox(
            height: 36,
          ),
          _countryGridWidget()
        ],
      ),
    );
  }

  /// Build main country widget
  Widget _mainCountryWidget(CountryModel data) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              data.countryFlag,
              height: AppValues.size_94,
            ).paddingOnly(right: AppValues.size_16),
            Text(
              data.countryName,
              style: _textTheme.labelLarge?.copyWith(
                  fontFamily: AppConstants.poppins,
                  fontWeight: FontWeight.bold,
                  color: AppColors.colorPrimary),
            )
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Text(
          data.countryAddress,
          textAlign: TextAlign.center,
          style: _textTheme.labelLarge?.copyWith(
              fontFamily: AppConstants.poppins,
              color: AppColors.textColorContent),
        )
      ],
    ).paddingAll(AppValues.size_10);
  }

  /// Build the Other Country Grid widget
  Widget _countryGridWidget() {
    return GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 1.6,
            mainAxisSpacing: 12,
            crossAxisSpacing: 12),
        itemCount: AppConstants.otherCountryData.length,
        itemBuilder: (context, index) {
          return _countryGridItem(AppConstants.otherCountryData[index]);
        });
  }

  /// Build the grid item
  Widget _countryGridItem(CountryModel data) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(
          data.countryFlag,
          height: AppValues.size_68,
        ).paddingOnly(bottom: AppValues.size_10),
        Text(
          data.countryName,
          textAlign: TextAlign.center,
          style: _textTheme.labelMedium?.copyWith(
              fontFamily: AppConstants.poppins,
              fontWeight: FontWeight.bold,
              color: AppColors.colorPrimary),
        ),
        const SizedBox(
          height: 2,
        ),
        Text(
          data.countryAddress,
          textAlign: TextAlign.center,
          style: _textTheme.labelMedium?.copyWith(
              fontFamily: AppConstants.poppins,
              fontWeight: FontWeight.bold,
              color: AppColors.textColorContent),
        )
      ],
    );
  }
}
