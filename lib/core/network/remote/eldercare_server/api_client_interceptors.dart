import 'package:dio/dio.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';

import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../local/isar/isar_database.dart';

class ApiClientInterceptors extends InterceptorsWrapper with IsarDatabase {
  ApiClientInterceptors({required this.dio});

  final Dio dio;
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    super.onRequest(options, handler);
  }

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    super.onError(err, handler);

    if (!await InternetConnectionChecker().hasConnection) {
      Logger.e('Internet disconnected');
    }
  }
}
