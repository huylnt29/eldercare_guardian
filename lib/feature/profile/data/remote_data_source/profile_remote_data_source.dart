import 'dart:io';

import 'package:dio/dio.dart';
import 'package:eldercare_guardian/core/network/remote/eldercare_server/eldercare_client.dart';
import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../core/model/profile_model.dart';

class ProfileRemoteDataSource {
  ProfileRemoteDataSource(this.elderCareClient);
  final ElderCareClient elderCareClient;

  Future<Profile> getProfileById(String guardianId) async {
    final response = await elderCareClient.getProfileById(guardianId);
    return response;
  }

  Future<Profile> putProfileById(String guardianId, Profile profile) async {
    final response = await elderCareClient.putProfileById(
      guardianId,
      profile.toJson(),
    );
    return response;
  }

  Future<EducationArtifact> postEducationArtifact(
    String guardianId,
    EducationArtifact educationArtifact,
  ) async {
    final response = await elderCareClient.postEducationArtifact(
      guardianId,
      educationArtifact,
    );
    return response;
  }

  Future<EducationArtifact> putEducationArtifactById(
    EducationArtifact educationArtifact,
  ) async {
    final response = await elderCareClient.putCertificateById(
      educationArtifact.id!,
      educationArtifact.toJson(),
    );
    return response;
  }

  Future<bool> postEducationArtifactEvidence(
    String educationArtifactId,
    String filePath,
  ) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      "file": await MultipartFile.fromFile(
        filePath,
        filename: fileName,
      ),
    });
    try {
      await Dio().post(
        '${dotenv.env['ELDERCARE_SERVER_URL']}/certificate/$educationArtifactId/image',
        data: formData,
      );
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<dynamic> deleteEducationArtifact(
    String guardianId,
    EducationArtifact educationArtifact,
  ) async {
    final response = await elderCareClient.deleteEducationArtifact(
      guardianId,
      educationArtifact.id!,
    );
    return response;
  }

  Future<dynamic> postExperience(
    String guardianId,
    Experience experience,
  ) async {
    final response = await elderCareClient.postExperience(
      guardianId,
      experience,
    );
    return response;
  }

  Future<Experience> putExperienceById(
    Experience experience,
  ) async {
    final response = await elderCareClient.putExperienceById(
      experience.id!,
      experience.toJson(),
    );
    return response;
  }

  Future<dynamic> deleteExperience(
    String guardianId,
    Experience experience,
  ) async {
    final response = await elderCareClient.deleteExperience(
      guardianId,
      experience.id!,
    );
    return response;
  }
}
