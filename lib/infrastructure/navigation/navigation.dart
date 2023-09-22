import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  EnvironmentsBadge({required this.child});

  @override
  Widget build(BuildContext context) {
    return SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashScreen(),
      binding: SplashControllerBinding(),
    ),
    GetPage(
      name: Routes.SYNCHRONISATION,
      page: () => SynchronisationScreen(),
      binding: SynchronisationControllerBinding(),
    ),
    GetPage(
      name: Routes.HOME,
      page: () => HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.PORTFOLIO,
      page: () => PortfolioScreen(),
      binding: PortfolioControllerBinding(),
    ),
    GetPage(
      name: Routes.ENQUIRY,
      page: () => const EnquiryScreen(),
      binding: EnquiryControllerBinding(),
    ),
    GetPage(
      name: Routes.SEARCH,
      page: () => const SearchScreen(),
      binding: SearchControllerBinding(),
    ),
    GetPage(
      name: Routes.PROJECT_LIST,
      page: () => ProjectListScreen(),
      binding: ProjectListControllerBinding(),
    ),
    GetPage(
      name: Routes.PROJECT_DETAIL,
      page: () => ProjectDetailScreen(),
      binding: ProjectDetailControllerBinding(),
    ),
    GetPage(
      name: Routes.BOARD_MEMBER_SLIDER,
      page: () => BoardMemberSliderScreen(),
      binding: BoardMemberSliderControllerBinding(),
    ),
  ];
}
