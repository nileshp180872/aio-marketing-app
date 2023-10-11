import 'package:aio/config/app_strings.dart';
import 'package:aio/utils/app_loading.mixin.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';

import '../../../infrastructure/db/database_helper.dart';
import '../../../infrastructure/db/schema/enquiry.dart';
import '../../../utils/utils.dart';
import '../provider/enquiry.provider.dart';

class EnquiryController extends GetxController with AppLoadingMixin {
  // Form Key
  final GlobalKey<FormState> enquiryFormKey = GlobalKey<FormState>();

  // Db helper
  late DatabaseHelper _dbHelper;

  /// Provider
  final _provider = EnquiryProvider();

  // Textfield Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  // Focus Node
  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode companyNameFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  // Local Fields
  String _name = "";
  String _email = "";
  String _phoneNumber = "";
  String _companyName = "";
  String _message = "";
  RxBool loading = false.obs;

  // Logger
  final logger = Logger();

  @override
  void onInit() {
    _initialiseLocalFields();
    super.onInit();
  }

  /// Initialise local fields.
  void _initialiseLocalFields() {
    _dbHelper = GetIt.I<DatabaseHelper>();
  }

  /// set name
  void setName(String value) {
    _name = value;
  }

  /// set email
  void setEmail(String value) {
    _email = value;
  }

  /// set phone number
  void setPhoneNumber(String value) {
    _phoneNumber = value;
  }

  /// set company Name
  void setCompanyName(String value) {
    _companyName = value;
  }

  /// set message
  void setMessage(String value) {
    _message = value;
  }

  /// submit enquiry
  void submit() async {
    if (enquiryFormKey.currentState!.validate()) {
      if (_validateFields()) {
        loading.value = true;
        _saveEntryToDb();
      }
    }
    loading.value = false;
  }

  ///Store entry to db and later it will by sync with server.
  void _saveEntryToDb() async {
    try {
      final enquiry = Enquiry();
      enquiry.enquiryId = DateTime.now().toIso8601String();
      enquiry.enquiryMemberName = _name;
      enquiry.enquiryMemberEmail = _email;
      enquiry.enquiryMemberPhone = _phoneNumber;
      enquiry.enquiryMemberCompany = _companyName;
      enquiry.enquiryMemberMessage = _message;
      enquiry.enquirySyncStatus = 0;

      if (await Utils.isConnected()) {
        _addEnquiry(enquiry);
      } else {
        final enquiryResponse = await _dbHelper.addToEnquiry(enquiry);
        if (enquiryResponse != -1) {
          loading.value = false;
          Utils.showSuccessDialog(message: AppStrings.enquiryAddSuccess);
        }
      }
    } catch (ex) {
      loading.value = false;
      logger.e(ex);
    }
  }

  /// Return true of form validation is valid.
  bool _validateFields() {
    if (emailInvalid()) {
      return false;
    }

    if (phoneNumberInvalid()) {
      return false;
    }
    return true;
  }

  /// Return true if user entered invalid email.
  bool emailInvalid() => !_email.isEmail;

  /// Returns false if phone number is invalid.
  bool phoneNumberInvalid() =>
      !_phoneNumber.isPhoneNumber ||
      _phoneNumber.length < 10 ||
      _phoneNumber.length > 15;

  /// Add enquiry API.
  Future<void> _addEnquiry(Enquiry enquiry) async {
    // showLoading();
    loading.value = true;
    final response = await _provider.addInquiry(enquiry);
    // hideLoading();
    if (response.data != null) {
      if (response.statusCode == 200) {
        loading.value = false;
        Utils.showSuccessDialog(message: AppStrings.enquiryAddSuccess);
      } else {
        loading.value = false;
        _addEnquiryAPIError(response);
      }
    }
  }

  /// Add enquiry API success
  ///
  /// required [response] response.
  void _addEnquiryAPISuccess(dio.Response response, int pageKey) async {
    try {
      if (response.statusCode == 200) {}
    } catch (ex) {
      logger.e(ex);
    }
  }

  /// Domain error
  ///
  /// required [response] response.
  void _addEnquiryAPIError(dio.Response response) {
    final snackBar = SnackBar(
      elevation: 4,
      duration: const Duration(seconds: 5),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.red,
      content: Text(response.statusMessage ?? ""),
    );

    ScaffoldMessenger.of(Get.context!)
      ..hideCurrentSnackBar()
      ..clearSnackBars()
      ..showSnackBar(snackBar);
  }
}
