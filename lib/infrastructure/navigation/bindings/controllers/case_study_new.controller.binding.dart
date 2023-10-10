import 'package:get/get.dart';

import '../../../../presentation/case_study_new/controllers/case_study_new.controller.dart';
import '../../routes.dart';

class CaseStudyNewControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CaseStudyNewController>(
      () => CaseStudyNewController(),
        tag: Routes.CASE_STUDY_NEW
    );
  }
}
