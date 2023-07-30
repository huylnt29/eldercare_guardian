import 'package:dio/dio.dart';
import 'package:eldercare_guardian/core/model/profile_model.dart';
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

  @GET('/guardian/{guardianId}')
  Future<Profile> getProfileById(@Path('guardianId') String guardianId);

  @PUT('/guardian/{guardianId}')
  Future<dynamic> putProfileById(
    @Path('guardianId') String guardianId,
    @Body() Map<String, dynamic> body,
  );
}
