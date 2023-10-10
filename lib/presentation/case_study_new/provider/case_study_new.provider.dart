import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../infrastructure/network/config/dio_provider.dart';
import '../../../infrastructure/network/network_constants.dart';

class CaseStudyNewProvider {

  /// Returns list of case stuies.
  Future<Response> getCaseStudy() async {
    return await GetIt.I<DioProvider>()
        .getBaseAPI(url: NetworkAPIs.kNewCaseStudies);
  }
}
