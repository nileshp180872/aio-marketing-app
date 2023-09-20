import 'package:aio/infrastructure/network/network_constants.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/network/config/dio_provider.dart';

class SynchronisationProvider {
  /// Returns list of domains.
  Future<Response> getDomains() async {
    return GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kDomains);
  }

  /// Returns list of technologies.
  Future<Response> getTechnologies() async {
    return GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kTechnologies);
  }

  /// Returns list of leadership.
  Future<Response> getLeadership() async {
    return GetIt.I<DioProvider>().getBaseAPI(url: NetworkAPIs.kLeadership);
  }
}
