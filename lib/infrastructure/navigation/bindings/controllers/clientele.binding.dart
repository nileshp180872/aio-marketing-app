import 'package:aio/presentation/clientele/controllers/clientele.controller.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

import '../../routes.dart';

class ClienteleBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ClientteleCotroller>(
            () => ClientteleCotroller(),
        tag: Routes.CLIENTELE
    );
  }
}
