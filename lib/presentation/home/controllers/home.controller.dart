import 'package:chewie/chewie.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../../../config/app_assets.dart';
import '../../../infrastructure/navigation/route_arguments.dart';
import '../../../infrastructure/navigation/routes.dart';
import '../../portfolio/controllers/portfolio.controller.dart';

class HomeController extends GetxController {
  /// Enable to show overlay widget.
  RxBool overlayEnabled = true.obs;

  late ChewieController chewieController;

  /// video player controller
  late Rx<VideoPlayerController> videoPlayerController =
      VideoPlayerController.asset(AppAssets.kCompanyVideo).obs;

  /// Store true when user request to play video otherwise false.
  bool userRequested = false;

  @override
  void onInit() {
    _initialiseVideoPlayer();
    super.onInit();
  }

  @override
  void dispose() {
    videoPlayerController.value.dispose();
    chewieController.dispose();
    super.dispose();
  }

  /// Initialise video player.
  void _initialiseVideoPlayer() async {
    await videoPlayerController.value.initialize();
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController.value,
      autoPlay: true,
      showControlsOnInitialize: false,
      looping: true,
      allowFullScreen: true,
      hideControlsTimer: const Duration(seconds: 1),
      autoInitialize: true,
    );
    videoPlayerController.value.addListener(() {
      if (!videoPlayerController.value.value.isPlaying) {
        overlayEnabled.value = true;
      } else {
        overlayEnabled.value = !userRequested;
      }
    });
    videoPlayerController.refresh();
  }

  /// Play video muted
  void _playVideoMuted() {
    videoPlayerController.value.seekTo(const Duration(seconds: 0));
    videoPlayerController.value.setVolume(0.0);
    videoPlayerController.value.play();
  }

  /// Navigate to synchronisation.
  void navigateToSynchronisation() {
    Get.toNamed(Routes.SYNCHRONISATION);
  }

  /// Hide overlay and play video.
  void hideOverlayAndLoadVideo() {
    userRequested = true;
    videoPlayerController.value.setVolume(1.0);
    videoPlayerController.value.seekTo(const Duration(seconds: 0));
    videoPlayerController.value.play();
  }

  /// on portfolio click
  void navigateToPortfolio() {
    Get.toNamed(Routes.PROJECT_LIST);
  }

  /// on caseStudy click
  void navigateToCaseStudy() {
    Get.toNamed(Routes.PROJECT_LIST,
        arguments: {RouteArguments.portfolioEnum: PortfolioEnum.CASE_STUDY});
    // Get.toNamed(Routes.CASE_STUDY_NEW);
  }

  /// on leadership click
  void navigateToLeadership() {
    Get.toNamed(Routes.BOARD_MEMBER_SLIDER);
  }

  /// on enquiry click
  void navigateToEnquiry() {
    Get.toNamed(Routes.ENQUIRY);
  }

  /// on clientele click
  void navigateToClientele() {
    Get.toNamed(Routes.CLIENTELE);
  }
}
