import 'package:aio/infrastructure/navigation/routes.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {

  @override
  void onInit() {
    _setupScreens();
    super.onInit();
  }

  /// Setup screens
  void _setupScreens() {
    Future.delayed(const Duration(seconds: 2), _navigateToHome);
  }

  /// Navigate to home
  void _navigateToHome() => Get.offAllNamed(Routes.SYNCHRONISATION);
}
