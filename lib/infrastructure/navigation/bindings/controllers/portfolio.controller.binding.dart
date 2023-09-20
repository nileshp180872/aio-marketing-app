import 'package:get/get.dart';

import '../../../../presentation/portfolio/controllers/portfolio.controller.dart';
import '../../routes.dart';

class PortfolioControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PortfolioController>(
      () => PortfolioController(),tag: Routes.PORTFOLIO

    );
  }
}
