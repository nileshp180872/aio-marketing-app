import 'package:get/get.dart';

import '../../../../presentation/project_list/controllers/project_list.controller.dart';
import '../../routes.dart';

class ProjectListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ProjectListController>(() => ProjectListController(),
        tag: Routes.PROJECT_LIST);
  }
}
