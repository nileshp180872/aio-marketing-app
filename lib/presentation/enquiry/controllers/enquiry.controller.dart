import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../utils/utils.dart';

class EnquiryController extends GetxController {

  final GlobalKey<FormState> enquiryFormKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController companyNameController = TextEditingController();
  TextEditingController messageController = TextEditingController();

  FocusNode emailFocusNode = FocusNode();
  FocusNode nameFocusNode = FocusNode();
  FocusNode phoneNumberFocusNode = FocusNode();
  FocusNode companyNameFocusNode = FocusNode();
  FocusNode messageFocusNode = FocusNode();

  String _name = "";
  String _email = "";
  String _phoneNumber = "";
  String _companyName = "";
  String _message = "";

  void setName(String value) {
    _name = value;
  }

  void setEmail(String value) {
    _email = value;
  }

  void setPhoneNumber(String value) {
    _phoneNumber = value;
  }

  void setCompanyName(String value) {
    _companyName = value;
  }

  void setMessage(String value) {
    _message = value;
  }

  void submit(){
    if(enquiryFormKey.currentState!.validate()){
      Utils.showSuccessDialog(message: 'Your enquiry is saved!');
    }
  }
}
