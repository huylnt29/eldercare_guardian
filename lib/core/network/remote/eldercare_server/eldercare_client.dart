import 'package:dio/dio.dart';
import 'package:eldercare_guardian/core/model/profile_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
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
  Future<Profile> putProfileById(
    @Path('guardianId') String guardianId,
    @Body() Map<String, dynamic> body,
  );

  @POST('/guardian/{guardianId}/certificate')
  Future<EducationArtifact> postEducationArtifact(
    @Path('guardianId') String guardianId,
    @Body() EducationArtifact educationArtifact,
  );

  @PUT('/certificate/{certificateId}')
  Future<EducationArtifact> putCertificateById(
    @Path('certificateId') String certificateId,
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

  @PUT('/experience/{experienceId}')
  Future<Experience> putExperienceById(
    @Path('experienceId') String experienceId,
    @Body() Map<String, dynamic> body,
  );

  @DELETE('/guardian/{guardianId}/experience/{experienceId}')
  Future<dynamic> deleteExperience(
    @Path('guardianId') String guardianId,
    @Path('experienceId') String experienceId,
  );
}
