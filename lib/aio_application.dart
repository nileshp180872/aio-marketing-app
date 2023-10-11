import 'package:aio/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'config/app_theme.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

class AIOApplication extends StatefulWidget {
  const AIOApplication({super.key});

  @override
  State<AIOApplication> createState() => _AIOApplicationState();
}

class _AIOApplicationState extends State<AIOApplication> {
  @override
  void initState() {
    super.initState();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    // Hide both overlays
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
  }

  @override
  dispose() {
    //Show both overlays
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
        return MediaQuery(
          child: child!,
          data: MediaQuery.of(context).copyWith(textScaleFactor: scale),
        );
      },
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: appTheme,
      initialRoute: Routes.SPLASH,
      getPages: Nav.routes,
    );
  }
}
