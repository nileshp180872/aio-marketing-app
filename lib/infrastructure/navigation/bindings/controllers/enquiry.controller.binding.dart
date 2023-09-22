import 'package:get/get.dart';

import '../../../../presentation/enquiry/controllers/enquiry.controller.dart';
import '../../routes.dart';

class EnquiryControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<EnquiryController>(
      () => EnquiryController(),
        tag: Routes.ENQUIRY
    );
  }
}
