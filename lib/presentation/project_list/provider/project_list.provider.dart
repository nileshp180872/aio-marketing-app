import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../config/app_constants.dart';
import '../../../infrastructure/network/config/dio_provider.dart';
import '../../../infrastructure/network/network_constants.dart';

class ProjectListProvider {
  /// Returns list of portfolios.
  Future<Response> getAllPortfolios({
    int offset = 0,
    String search = "",
    required List<String> domains,
    required List<String> screens,
    required List<String> technologies,
    bool filterApplied = false,
  }) async {
    Map<String, dynamic> queryParams = {
      NetworkParams.limit: AppConstants.paginationPageLimit,
      NetworkParams.page: offset,
      if (search.trim().isNotEmpty) NetworkParams.searchKey: search
    };

    if (domains.isNotEmpty) {
      for (int i = 0; i < domains.length; i++) {
        queryParams.addAll({
          "${NetworkParams.domainId}[$i]": domains[i].replaceAll("'", ""),
        });
      }
    }
    if (screens.isNotEmpty) {
      for (int i = 0; i < screens.length; i++) {
        queryParams.addAll({
          "${NetworkParams.screenId}[$i]": screens[i].replaceAll("'", ""),
        });
      }
    }
    if (technologies.isNotEmpty) {
      for (int i = 0; i < technologies.length; i++) {
        queryParams.addAll({
          "${NetworkParams.techId}[$i]": technologies[i].replaceAll("'", ""),
        });
      }
    }

    return await GetIt.I<DioProvider>()
        .getBaseAPI(url: NetworkAPIs.kPortfolio, queryParams: queryParams);
  }

  /// Returns list of case studies.
  Future<Response> getCaseStudies({
    int offset = 0,
    String search = "",
    required List<String> domains,
    required List<String> technologies,
  }) async {
    Map<String, dynamic> queryParams = {
      NetworkParams.limit: AppConstants.paginationPageLimit,
      NetworkParams.page: offset,
      if (search.trim().isNotEmpty) NetworkParams.searchKey: search
    };

    if (domains.isNotEmpty) {
      for (int i = 0; i < domains.length; i++) {
        queryParams.addAll({
          "${NetworkParams.domainId}[$i]": domains[i].replaceAll("'", ""),
        });
      }
    }

    if (technologies.isNotEmpty) {
      for (int i = 0; i < technologies.length; i++) {
        queryParams.addAll({
          "${NetworkParams.techId}[$i]": technologies[i].replaceAll("'", ""),
        });
      }
    }
    return await GetIt.I<DioProvider>()
        .getBaseAPI(url: NetworkAPIs.kCaseStudies, queryParams: queryParams);
  }
}
