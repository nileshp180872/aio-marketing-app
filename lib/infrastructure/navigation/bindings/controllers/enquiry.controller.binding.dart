import 'package:get/get.dart';

import '../../../../presentation/enquiry/controllers/enquiry.controller.dart';

class EnquiryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnquiryController>(
      () => EnquiryController(),
    );
  }
}
