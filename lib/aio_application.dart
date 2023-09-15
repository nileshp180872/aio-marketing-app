import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

class AIOApplication extends StatelessWidget {
  const AIOApplication({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "Application",
      initialRoute: Routes.SPLASH,
      getPages: Nav.routes,
    );
  }
}
