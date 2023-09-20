import 'package:get/get.dart';

import '../../../../presentation/home/controllers/home.controller.dart';
import '../../routes.dart';

class HomeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
        tag: Routes.HOME
    );
  }
}
