import 'package:get/get.dart';

import '../../../../presentation/splash/controllers/splash.controller.dart';
import '../../routes.dart';

class SplashControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(
      () => SplashController(),
        tag: Routes.SPLASH
    );
  }
}
