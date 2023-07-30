import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/feature/profile/data/local_data_source/profile_local_data_source.dart';
import 'package:eldercare_guardian/feature/profile/data/remote_data_source/profile_remote_data_source.dart';

import '../../../../core/model/profile_model.dart';

class ProfileRepositoryImpl {
  ProfileLocalDataSource profileLocalDataSource;
  ProfileRemoteDataSource profileRemoteDataSource;
  ProfileRepositoryImpl(
    this.profileLocalDataSource,
    this.profileRemoteDataSource,
  );

  Future<Profile> getProfileById() async {
    final localProfile = await profileLocalDataSource.getProfileById(
      FakedData.guardianId,
    );
    if (localProfile != null) {
      return localProfile;
    }
    final remoteProfile = await profileRemoteDataSource.getProfileById(
      FakedData.guardianId,
    );
    return remoteProfile;
  }

  Future<int> putProfileRemoteToLocal(Profile remoteProfile) async {
    final response = await profileLocalDataSource.putProfile(
      FakedData.guardianId,
      remoteProfile,
    );
    return response;
  }
}
