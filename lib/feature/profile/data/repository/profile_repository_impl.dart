import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/feature/profile/data/local_data_source/profile_local_data_source.dart';
import 'package:eldercare_guardian/feature/profile/data/remote_data_source/profile_remote_data_source.dart';

import '../../../../core/model/profile_model.dart';
import '../model/education_artifact_model.dart';
import '../model/experience_model.dart';

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

  Future<Profile> putProfileById(Profile profile) async {
    final response = await profileRemoteDataSource.putProfileById(
      FakedData.guardianId,
      profile,
    );
    return response;
  }

  Future<int> putProfileRemoteToLocal(Profile remoteProfile) async {
    final response = await profileLocalDataSource.putProfile(
      remoteProfile,
    );
    return response;
  }

  Future<EducationArtifact> postEducationArtifact(
      EducationArtifact educationArtifact) async {
    final response = await profileRemoteDataSource.postEducationArtifact(
      FakedData.guardianId,
      educationArtifact,
    );
    return response;
  }

  Future<bool> postEducationArtifactEvidence(
    EducationArtifact educationArtifact,
    String filePath,
  ) async {
    final response =
        await profileRemoteDataSource.postEducationArtifactEvidence(
      educationArtifact.id!,
      filePath,
    );
    return response;
  }

  Future<EducationArtifact> putEducationArtifactById(
      EducationArtifact educationArtifact) async {
    final response = await profileRemoteDataSource.putEducationArtifactById(
      educationArtifact,
    );
    return response;
  }

  Future<dynamic> deleteEducationArtifact(
    EducationArtifact educationArtifact,
  ) async {
    final response = await profileRemoteDataSource.deleteEducationArtifact(
      FakedData.guardianId,
      educationArtifact,
    );
    return response;
  }

  Future<dynamic> postExperience(Experience experience) async {
    final response = await profileRemoteDataSource.postExperience(
      FakedData.guardianId,
      experience,
    );
    return response;
  }

  Future<Experience> putExperiencById(Experience experience) async {
    final response = await profileRemoteDataSource.putExperienceById(
      experience,
    );
    return response;
  }

  Future<dynamic> deleteExperience(
    Experience experience,
  ) async {
    final response = await profileRemoteDataSource.deleteExperience(
      FakedData.guardianId,
      experience,
    );
    return response;
  }

  Future<bool> deleteProfile() async {
    final response = await profileLocalDataSource.deleteProfile(
      FakedData.guardianId,
    );
    return response;
  }
}
