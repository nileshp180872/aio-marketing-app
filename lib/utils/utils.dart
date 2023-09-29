import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../infrastructure/navigation/routes.dart';
import '../presentation/enquiry/view/success_dialog_widget.dart';

class Utils {
  /// Returns status if device has internet available.
  ///
  /// Return true if network available otherwise false.
  static Future<bool> isConnected() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      return true;
    }
    return false;
  }

  static TextFormField buildBaseTextField({
    required TextEditingController controller,
    required String label,
    required FocusNode focusNode,
    List<TextInputFormatter>? inputFormatters,
    required Function(String newValue) onChange,
    bool isEmail = false,
    bool isPhoneNumber = false,
    bool isMultiline = false,
    required String? Function(String?)? onValidate,
  }) {
    const textStyle = TextStyle(
        color: AppColors.colorSecondary,
        fontSize: 16,
        fontFamily: AppConstants.sourceSansPro);
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      inputFormatters: inputFormatters,
      maxLength: isMultiline
          ? AppConstants.multiLineMaxLength
          : AppConstants.textFieldMaxLength,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      validator: onValidate,
      onChanged: onChange,
      keyboardType: isEmail
          ? TextInputType.emailAddress
          : isPhoneNumber
              ? TextInputType.phone
              : isMultiline
                  ? TextInputType.multiline
                  : TextInputType.text,
      style: textStyle,
      maxLines: isMultiline ? 3 : 1,
      enableSuggestions: true,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      textInputAction:
          isMultiline ? TextInputAction.newline : TextInputAction.next,
      decoration: InputDecoration(
        label: Text(label),
        // errorStyle: textStyle.copyWith(color: Colors.red[900], fontSize: 14),
        alignLabelWithHint: true,
        counter: const Offstage(),
        labelStyle: textStyle,
      ),
    );
  }

  static void showSuccessDialog({required String message}) {
    Get.dialog(SuccessDialogWidget(
      contentText: message,
      onSubmit: () {
        Get.until((route) => route.settings.name == Routes.HOME);
      },
    ));
  }

  /// Return string date with yyyy-MM-dd format.
  static String getTodayDate() {
    var now = DateTime.now();
    var formatter = DateFormat('yyyy-MM-dd');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }
}
