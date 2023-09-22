import 'package:get/get.dart';

import '../../../../presentation/project_detail/controllers/project_detail.controller.dart';
import '../../routes.dart';

class ProjectDetailControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectDetailController>(
      () => ProjectDetailController(),
      tag: Routes.PROJECT_DETAIL
    );
  }
}
