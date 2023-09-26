import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'aio_application.dart';
import 'infrastructure/cache/shared_cofig.dart';
import 'infrastructure/db/database_helper.dart';
import 'infrastructure/network/config/dio_provider.dart';
import 'infrastructure/network/http_override.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _setupScreens();

  HttpOverrides.global = MyHttpOverrides();

  runApp(const AIOApplication());
}

void _setupScreens() {
  final getIt = GetIt.instance;

  getIt.registerSingleton<SharedPreference>(SharedPreference());
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper());
  getIt.registerSingleton<DioProvider>(DioProvider());

  // Initialise database
  getIt<DatabaseHelper>().initialiseDb();
  getIt<DioProvider>().initialise();
}
