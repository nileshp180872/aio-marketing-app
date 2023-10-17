import 'dart:io';

import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

import '../infrastructure/navigation/routes.dart';
import '../infrastructure/network/model/case_studies_response.dart';
import '../infrastructure/network/network_constants.dart';
import '../presentation/enquiry/view/success_dialog_widget.dart';
import '../presentation/project_list/model/project_list_model.dart';

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
    bool enableCapital = false,
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
          : isPhoneNumber
              ? AppConstants.phoneMaxLength
              : AppConstants.textFieldMaxLength,
      onTapOutside: (_) {
        focusNode.unfocus();
      },
      validator: onValidate,
      onChanged: onChange,
      textCapitalization: enableCapital
          ? TextCapitalization.sentences
          : TextCapitalization.none,
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

  static void showSuccessDialog(
      {bool navigateToHome = true, required String message}) {
    Get.dialog(SuccessDialogWidget(
      contentText: message,
      navigateToHome: navigateToHome,
      onSubmit: () {
        if (navigateToHome) {
          Get.until((route) => route.settings.name == Routes.HOME);
        } else {
          Get.back();
        }
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

  static void showErrorMessage({required String message}) {
    final snackBar = SnackBar(
      elevation: 4,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(message),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }

  static ProjectListModel getProjectDetailFromCaseStudy(
      CaseStudiesResponseData element) {
    final images = (element.imageMapping ?? [])
        .map((e) => e.casestudiesImage ?? "")
        .toList();
    final technologies =
        (element.techMapping ?? []).map((e) => e.techName ?? "").toList();
    Get.log("technologies ${technologies}");
    String strTechnologies = "";
    final techMapping = (element.techImageMapping ?? []);
    if (techMapping.isNotEmpty) {
      strTechnologies =
          (techMapping.map((e) => e.techImage ?? "").toList()).join(",");
    }
    (element.techImageMapping ?? []).isEmpty
        ? null
        : (element.techImageMapping ?? [])
            .map((e) => (e.techImage ?? "").split(","));
    final model = ProjectListModel(
        id: element.casestudiesID,
        projectName: element.projectName,
        networkImages: [element.thumbnailImage ?? ""],
        overView: element.domainName,
        domainName: element.domainName,
        businessImage1: element.businessImage1,
        businessImage2: element.businessImage2,
        businessImage3: element.businessImage3,
        companyName: element.companyTitle,
        companyDescription: element.companyDescription,
        conclusion: element.conclusion,
        urlLink: element.urlLink,
        companyImage: element.companyImage,
        businessTitle1: element.businessTitle1,
        businessTitle2: element.businessTitle2,
        businessTitle3: element.businessTitle3,
        casestudyThumbnailImage: element.thumbnailImage,
        casestudyBannerImage: element.bannerImage,
        solutionTitle1: element.solutionTitle1,
        solutionTitle2: element.solutionTitle2,
        solutionTitle3: element.solutionTitle3,
        solutionImage1: element.solutionImage1,
        solutionImage2: element.solutionImage2,
        solutionImage3: element.solutionImage3,
        solutionDescription1: element.solutionDescription1,
        solutionDescription2: element.solutionDescription2,
        solutionDescription3: element.solutionDescription3,
        businessDescription1: element.description1,
        businessDescription2: element.description2,
        businessDescription3: element.description3,
        technologies: technologies.join(","),
        techMapping: techMapping.map((e) => e.techImage ?? "").toList(),
        sliderImages: (element.imageMapping ?? []).isEmpty
            ? null
            : (element.imageMapping ?? [])
                .map((e) => e.casestudiesImage ?? "")
                .toList(),
        viewType: AppConstants.caseStudy);

    return model;
  }

  static Future<String> getImagePath({
    required String imageURL,
    required String locationName,
  }) async {
    final thumbnailFileName = imageURL.split(".")[0];
    try {
      final data = thumbnailFileName.isNotEmpty
          ? await getImageFilePath(
              '${NetworkConstants.kImageBasePath}$imageURL',
              locationName,
              thumbnailFileName,
            )
          : "";
      return data;
    } catch (ex) {
      print("thumbnail errror $ex");
      return "";
    }
  }

  /// Return image full path from device storage.
  ///
  /// 1. Download and store image from url.
  /// 2. Return saved destination path.
  ///
  /// required [imageUrl] as image need to downloaded.
  static Future<String> getImageFilePath(
      String imageUrl, String subPath, String fileName,
      {bool deleteFile = false}) async {
    var documentDirectory = await getApplicationDocumentsDirectory();

    var firstPath = "${documentDirectory.path}/images/$subPath/";

    var filePathAndName = '$firstPath/$fileName.png';
    File file = File(filePathAndName);
    if (await file.exists()) {
      file.delete(recursive: true);
      if (deleteFile) {
        return "";
      }
    }

    var response = await dio.Dio().download(imageUrl, filePathAndName,
        options: dio.Options(responseType: dio.ResponseType.bytes, persistentConnection: false));

    Get.log("response.data ${(response.data as dio.ResponseBody)}");
    return filePathAndName;
  }
}
