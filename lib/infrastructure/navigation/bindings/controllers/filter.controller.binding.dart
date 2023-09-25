import 'package:get/get.dart';

import '../../../../presentation/filter/controllers/filter.controller.dart';
import '../../routes.dart';

class FilterControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<FilterController>(
      () => FilterController(),tag: Routes.FILTER
    );
  }
}
