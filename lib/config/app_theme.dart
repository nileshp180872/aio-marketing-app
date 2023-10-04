import 'package:aio/config/app_colors.dart';
import 'package:aio/config/app_constants.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.colorPrimary,
  scaffoldBackgroundColor: Colors.white,
  fontFamily: AppConstants.sourceSansPro,
  textTheme: const TextTheme(
    bodySmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.colorSecondary),
    labelLarge: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        color: Colors.white),
    titleSmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
        letterSpacing:2.0,
        color: AppColors.colorSecondary),
    bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorContent),
      headlineSmall: TextStyle(
            fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: AppColors.colorSecondary),
    headlineLarge: TextStyle(
        fontSize: 40.0,
        fontWeight: FontWeight.w700,
        color: AppColors.colorSecondary),
  ),
);
