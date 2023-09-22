import 'package:get/get.dart';

import '../../../../presentation/search/controllers/global_search.controller.dart';
import '../../routes.dart';

class SearchControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<GlobalSearchController>(
      () => GlobalSearchController(),
      tag: Routes.SEARCH
    );
  }
}
