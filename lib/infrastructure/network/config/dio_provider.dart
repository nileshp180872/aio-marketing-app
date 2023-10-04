import 'package:aio/config/app_strings.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import '../../cache/shared_cofig.dart';
import '../network_constants.dart';

class DioProvider {
  late Dio mDio;

  void initialise() {
    mDio = Dio(
      BaseOptions(
        baseUrl: NetworkConstants.kProduction,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
      ),
    );
    mDio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        request: true));
  }

  /// Get base API.
  Future<Response> getBaseAPI(
      {required String url, Map<String, dynamic>? queryParams}) async {
    try {
      return await mDio.get(url, queryParameters: queryParams);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
            data: AppStrings.connectionTimeoutMessage,
            statusMessage: AppStrings.connectionTimeoutMessage,
            statusCode: 500,
            requestOptions: RequestOptions());
      }
      return Response(
          data: ex.message,
          statusMessage: ex.message,
          statusCode: 500,
          requestOptions: RequestOptions());
    }
  }

  /// Post base API.
  Future<Response> postBaseAPI({required String url, dynamic data}) async {
    try {
      return await mDio.post(url, data: data);
    } on DioException catch (ex) {
      if (ex.type == DioExceptionType.connectionTimeout) {
        return Response(
            data: AppStrings.connectionTimeoutMessage,
            statusMessage:  AppStrings.connectionTimeoutMessage,
            statusCode: 500,
            requestOptions: RequestOptions());
      }
      return Response(
          data: ex.message,
          statusMessage: ex.message,
          statusCode: 500,
          requestOptions: RequestOptions());
    }
  }
}
