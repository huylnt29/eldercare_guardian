import 'package:dio/dio.dart';

import 'api_client.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

import 'api_client_interceptors.dart';

class ApiClientConfig {
  static Dio initApiService({String? baseUrl}) {
    final dio = Dio();
    if (baseUrl != null) {
      dio.options.baseUrl = baseUrl;
    }
    dio.interceptors.add(ApiClientInterceptors(dio: dio));
    dio.options.connectTimeout = const Duration(seconds: 50);
    // dio.options.headers['Content-Type'] = 'application/json';

    dio.options.headers['Accept'] = '*/*';

    dio.interceptors.add(PrettyDioLogger(
      requestHeader: true,
      requestBody: true,
    ));

    return dio;
  }

  static ApiClient getApiClient() {
    final apiClient = ApiClient(initApiService());
    return apiClient;
  }
}
