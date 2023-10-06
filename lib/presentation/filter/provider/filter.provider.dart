import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/network/config/dio_provider.dart';
import '../../../infrastructure/network/network_constants.dart';

class FilterProvider{
  /// Returns list of domains.
  Future<Response> getDomains() async {
    return await GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kDomains);
  }

  /// Returns list of technologies.
  Future<Response> getTechnologies() async {
    return await GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kTechnologies);
  }
  /// Returns list of platform.
  Future<Response> getPlatforms() async {
    return await GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kPlatform);
  }
}