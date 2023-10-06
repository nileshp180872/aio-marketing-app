import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_constants.dart';
import '../../../infrastructure/network/config/dio_provider.dart';
import '../../../infrastructure/network/network_constants.dart';

class ProjectListProvider {
  /// Returns list of portfolios.
  Future<Response> getAllPortfolios(
      {int offset = 0, String search = ""}) async {
    Map<String, dynamic> queryParams = {
      NetworkParams.limit: AppConstants.paginationPageLimit,
      NetworkParams.page: offset,
      if (search.trim().isNotEmpty) NetworkParams.searchKey: search
    };

    return await GetIt.I<DioProvider>()
        .getBaseAPI(url: NetworkAPIs.kPortfolio, queryParams: queryParams);
  }

  /// Returns list of case studies.
  Future<Response> getCaseStudies({int offset = 0, String search = ""}) async {
    Map<String, dynamic> queryParams = {
      NetworkParams.limit: AppConstants.paginationPageLimit,
      NetworkParams.page: offset,
      if (search.trim().isNotEmpty) NetworkParams.searchKey: search
    };
    return await GetIt.I<DioProvider>()
        .getBaseAPI(url: NetworkAPIs.kCaseStudies, queryParams: queryParams);
  }
}
