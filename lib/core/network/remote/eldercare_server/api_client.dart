import 'package:dio/dio.dart';
import 'package:eldercare_guardian/core/model/profile_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';

import 'package:retrofit/retrofit.dart';

import '../../../../feature/schedule/view_schedule/data/model/task_model.dart';
import '../../../../feature/schedule/view_schedule/data/model/work_shift_model.dart';

part 'api_client.g.dart';

@RestApi()
abstract class ApiClient {
  factory ApiClient(
    Dio dio, {
    String baseUrl,
  }) = _ApiClient;

  /// TASK
  @GET('/task/guardian/{guardianId}')
  Future<List<Task>> getTasks(
    @Path('guardianId') String guardianId,
    @Query('date') String date, // format : YYYY-MM-DD
  );
  // __________________________________________________

  /// PROFILE
  @GET('/guardian/{id}')
  Future<Profile> getProfileById(@Path('id') String guardianId);

  @PUT('/guardian/{id}')
  Future<Profile> putProfileById(
    @Path('id') String guardianId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/guardian/{guardianId}/certificate')
  Future<EducationArtifact> postEducationArtifact(
    @Path('guardianId') String guardianId,
    @Body() EducationArtifact educationArtifact,
  );

  @PUT('/certificate/{id}')
  Future<EducationArtifact> putCertificateById(
    @Path('id') String certificateId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/guardian/{guardianId}/certificate/{certificateId}')
  Future<dynamic> deleteEducationArtifact(
    @Path('guardianId') String guardianId,
    @Path('certificateId') String certificateId,
  );

  @POST('/guardian/{guardianId}/experience')
  Future<Experience> postExperience(
    @Path('guardianId') String guardianId,
    @Body() Experience experience,
  );

  @PUT('/experience/{id}')
  Future<Experience> putExperienceById(
    @Path('id') String experienceId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/guardian/{guardianId}/experience/{experienceId}')
  Future<dynamic> deleteExperience(
    @Path('guardianId') String guardianId,
    @Path('experienceId') String experienceId,
  );
  // __________________________________________________

  /// SCHEDULE
  @GET('/schedule/guardian/{id}')
  Future<DayWorkShift> getScheduleByDate(
    @Path('id') String guardianId,
    @Query('date') String date,
  );

  @POST('/schedule')
  Future<WorkShift> postShift(
    @Body() Map<String, dynamic> body,
  );

  // @PATCH('/schedule')
  // Future<WorkShift> editShift(
  //   @Path('workShiftId') String workShiftId,
  //   @Body() Map<String, dynamic> body,
  // );

  @DELETE('/schedule/{id}')
  Future<dynamic> deleteWorkShift(
    @Path('id') String workShiftId,
  );
}