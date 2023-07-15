import 'package:dio/dio.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../../../extensions/logger.dart';
import '../../local/isar/isar_database.dart';

class ElderCareClientInterceptors extends InterceptorsWrapper
    with IsarDatabase {
  ElderCareClientInterceptors({required this.dio});

  final Dio dio;
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    // if (isarInstance == null) return;
    // final account = await isarInstance!.accounts.get(1);
    // if (account == null) return;
    // final idToken = account.firestoreIdToken;

    // if (idToken == null) {
    //   Logger.e('Empty bearer token');
    //   return;
    // }

    // if (idToken.isNotEmpty) {
    //   options.headers['Authorization'] = 'Bearer $idToken';
    //   Logger.i('Bearer $idToken');
    // }
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
