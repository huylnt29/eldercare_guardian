import 'package:eldercare_guardian/core/network/remote/eldercare_server/eldercare_client.dart';

import '../../../../core/model/profile_model.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this.elderCareClient);
  final ElderCareClient elderCareClient;

  Future<Profile> getProfileById(String guardianId) async {
    final response = await elderCareClient.getProfileById(guardianId);
    return response;
  }

  Future<dynamic> putProfileById(String guardianId, Profile profile) async {
    final response = await elderCareClient.putProfileById(
      guardianId,
      profile.toJson(),
    );
    return response;
  }
}
