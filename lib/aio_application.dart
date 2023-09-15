import 'package:aio/config/app_strings.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'config/app_theme.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

class AIOApplication extends StatelessWidget {
  const AIOApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: AppStrings.appName,
      theme: appTheme,
      initialRoute: Routes.SPLASH,
      getPages: Nav.routes,
    );
  }
}
