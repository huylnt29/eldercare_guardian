import 'package:eldercare_guardian/core/faked/faked_data.dart';
import 'package:eldercare_guardian/feature/profile/data/local_data_source/profile_local_data_source.dart';
import 'package:eldercare_guardian/feature/profile/data/remote_data_source/profile_remote_data_source.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/model/profile_model.dart';
import '../model/education_artifact_model.dart';
import '../model/experience_model.dart';

abstract class ProfileRepository {
  ProfileRepository(
    this.profileLocalDataSource,
    this.profileRemoteDataSource,
  );
  ProfileLocalDataSource profileLocalDataSource;
  ProfileRemoteDataSource profileRemoteDataSource;
  Future<Profile> getProfileById();
  Future<Profile> putProfileById(Profile profile);
  Future<int> putProfileRemoteToLocal(Profile remoteProfile);
  Future<EducationArtifact> postEducationArtifact(
    EducationArtifact educationArtifact,
  );
  Future<bool> postEducationArtifactEvidence(
    EducationArtifact educationArtifact,
    String filePath,
  );
  Future<EducationArtifact> putEducationArtifactById(
    EducationArtifact educationArtifact,
  );
  Future<dynamic> deleteEducationArtifact(
    EducationArtifact educationArtifact,
  );
  Future<dynamic> postExperience(Experience experience);
  Future<Experience> putExperiencById(Experience experience);
  Future<dynamic> deleteExperience(
    Experience experience,
  );
  Future<bool> deleteProfile();
}

@Injectable(as: ProfileRepository)
class ProfileRepositoryImpl extends ProfileRepository {
  ProfileRepositoryImpl(
    super.profileLocalDataSource,
    super.profileRemoteDataSource,
  );
  @override
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

  @override
  Future<Profile> putProfileById(Profile profile) async {
    final response = await profileRemoteDataSource.putProfileById(
      FakedData.guardianId,
      profile,
    );
    return response;
  }

  @override
  Future<int> putProfileRemoteToLocal(Profile remoteProfile) async {
    final response = await profileLocalDataSource.putProfile(
      remoteProfile,
    );
    return response;
  }

  @override
  Future<EducationArtifact> postEducationArtifact(
      EducationArtifact educationArtifact) async {
    final response = await profileRemoteDataSource.postEducationArtifact(
      FakedData.guardianId,
      educationArtifact,
    );
    return response;
  }

  @override
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

  @override
  Future<EducationArtifact> putEducationArtifactById(
      EducationArtifact educationArtifact) async {
    final response = await profileRemoteDataSource.putEducationArtifactById(
      educationArtifact,
    );
    return response;
  }

  @override
  Future<dynamic> deleteEducationArtifact(
    EducationArtifact educationArtifact,
  ) async {
    final response = await profileRemoteDataSource.deleteEducationArtifact(
      FakedData.guardianId,
      educationArtifact,
    );
    return response;
  }

  @override
  Future<dynamic> postExperience(Experience experience) async {
    final response = await profileRemoteDataSource.postExperience(
      FakedData.guardianId,
      experience,
    );
    return response;
  }

  @override
  Future<Experience> putExperiencById(Experience experience) async {
    final response = await profileRemoteDataSource.putExperienceById(
      experience,
    );
    return response;
  }

  @override
  Future<dynamic> deleteExperience(
    Experience experience,
  ) async {
    final response = await profileRemoteDataSource.deleteExperience(
      FakedData.guardianId,
      experience,
    );
    return response;
  }

  @override
  Future<bool> deleteProfile() async {
    final response = await profileLocalDataSource.deleteProfile(
      FakedData.guardianId,
    );
    return response;
  }
}
