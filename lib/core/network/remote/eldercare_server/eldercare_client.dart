import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../feature/schedule/data/model/task_model.dart';

part 'eldercare_client.g.dart';

@RestApi()
abstract class ElderCareClient {
  factory ElderCareClient(
    Dio dio, {
    String baseUrl,
  }) = _ElderCareClient;

  @GET('/task/guardian/{guardianId}')
  Future<List<Task>> getTasks(@Path('guardianId') String guardianId);
}
