import 'package:aio/config/app_colors.dart';
import 'package:flutter/material.dart';

final appTheme = ThemeData(
  primaryColor: AppColors.colorPrimary,
  fontFamily: 'Poppins',
  textTheme: const TextTheme(
    bodySmall: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.colorSecondary),
    bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: AppColors.textColorContent),
    headlineSmall: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
        color: AppColors.colorSecondary),
  ),
);
