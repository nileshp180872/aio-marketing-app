import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../network_constants.dart';
import '../../cache/shared_cofig.dart';

class DioProvider {
  late Dio mDio;

  void initialise() {
    mDio = Dio(
      BaseOptions(
        baseUrl: NetworkConstants.kDevelopment,
        headers: {
          if (GetIt.I<SharedPreference>().token.isNotEmpty)
            "Authorization": "Bearer ${GetIt.I<SharedPreference>().token}",
        },
      ),
    );
    mDio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true));
  }

  /// Get base API.
  Future<Response> getBaseAPI({required String url}) => mDio.get(url);

  /// Post base API.
  Future<Response> postBaseAPI({required String url, dynamic data}) =>
      mDio.post(url, data: data);

  /// Delete base API.
  Future<Response> deleteBaseAPI({required String url}) => mDio.delete(url);
}
