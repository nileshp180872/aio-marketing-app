import 'package:get/get.dart';

import '../../../../presentation/synchronisation/controllers/synchronisation.controller.dart';
import '../../routes.dart';

class SynchronisationControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SynchronisationController>(
      () => SynchronisationController(),
      tag: Routes.SYNCHRONISATION
    );
  }
}
