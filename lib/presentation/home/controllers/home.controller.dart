import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../config/app_assets.dart';
import '../../../infrastructure/navigation/routes.dart';

class HomeController extends GetxController {
  /// Enable to show overlay widget.
  RxBool overlayEnabled = true.obs;

  late ChewieController chewieController;

  /// video player controller
  late Rx<VideoPlayerController> videoPlayerController =
      VideoPlayerController.asset(AppAssets.kCompanyVideo).obs;

  @override
  void onInit() {
    _initialiseVideoPlayer();
    super.onInit();
  }

  @override
  void onClose() {
    videoPlayerController.value.dispose();
    chewieController.dispose();
    super.onClose();
  }

  /// Initialise video player.
  void _initialiseVideoPlayer() async {
    await videoPlayerController.value.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController.value,
      autoPlay: true,
      looping: true,
      allowFullScreen: true,
      autoInitialize: true,
    );

    videoPlayerController.refresh();
  }

  /// Navigate to synchronisation.
  void navigateToSynchronisation() {
    Get.toNamed(Routes.SYNCHRONISATION);
  }

  /// Hide overlay and play video.
  void hideOverlayAndLoadVideo() {
    overlayEnabled.value = false;
    videoPlayerController.value.setVolume(1.0);
    videoPlayerController.value.seekTo(const Duration(seconds: 0));
  }

  /// on portfolio click
  void navigateToPortfolio() {
    Get.toNamed(Routes.PORTFOLIO);
  }

  /// on enquiry click
  void navigateToEnquiry() {
    Get.toNamed(Routes.ENQUIRY);
  }
}
