part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class FetchDataForScreenEvent extends ProfileEvent {
  FetchDataForScreenEvent();
}

class PrepareTemporaryDataEvent extends ProfileEvent {
  PrepareTemporaryDataEvent();
}

class UpdateProfileEvent extends ProfileEvent {
  UpdateProfileEvent();
}

class AddMoreEducationArtifact extends ProfileEvent {
  AddMoreEducationArtifact();
}

class AddMoreExperience extends ProfileEvent {
  AddMoreExperience();
}

class TemporarilyPostEducationArtifactEvidence extends ProfileEvent {
  TemporarilyPostEducationArtifactEvidence(
    this.educationArtifactId,
    this.xFile,
  );
  String educationArtifactId;
  XFile xFile;
}

class DeleteEducationArtifact extends ProfileEvent {
  DeleteEducationArtifact(this.educationArtifact);
  final EducationArtifact educationArtifact;
}

class DeleteExperience extends ProfileEvent {
  DeleteExperience(this.experience);
  final Experience experience;
}
