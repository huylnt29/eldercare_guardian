import 'package:bloc/bloc.dart';
import 'package:camera/camera.dart';
import 'package:eldercare_guardian/core/model/profile_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/education_artifact_model.dart';
import 'package:eldercare_guardian/feature/profile/data/model/experience_model.dart';
import 'package:eldercare_guardian/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';
import 'package:huylnt_flutter_component/reusable_core/extensions/logger.dart';
import 'package:random_string/random_string.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileRepositoryImpl)
      : super(const ProfileState(loadState: LoadState.initial)) {
    on<FetchDataForScreenEvent>((event, emit) async {
      emit(state.copyWith(
        loadState: LoadState.loading,
        profileUpdatedSuccessfully: false,
      ));
      try {
        final response = await profileRepositoryImpl.getProfileById();
        emit(state.copyWith(
          profile: response,
          loadState: LoadState.loaded,
        ));
        await profileRepositoryImpl.putProfileRemoteToLocal(response);
      } on Exception {
        emit(state.copyWith(loadState: LoadState.error));
      }
    });
    on<PrepareTemporaryDataEvent>((event, emit) {
      emit(
        state.copyWith(
          tempProfile: state.profile!.copyWith(),
        ),
      );
    });
    on<UpdateProfileEvent>((event, emit) async {
      Logger.v('Right before profile being updated: ');
      Logger.d(state.tempProfile!.toJson());
      emit(state.copyWith(loadState: LoadState.loading));
      try {
        // Education artifact
        for (var element in state.tempProfile!.educationArtifacts) {
          if (element!.editionType ==
              EducationArtifactEditionType.originalModified) {
            final educationArtifact =
                await profileRepositoryImpl.putEducationArtifactById(element);
            await profileRepositoryImpl.postEducationArtifactEvidence(
              educationArtifact,
              element.imageEvidence!,
            );
          } else if (element.editionType ==
                  EducationArtifactEditionType.draft &&
              element.canBePosted) {
            final educationArtifact =
                await profileRepositoryImpl.postEducationArtifact(element);
            await profileRepositoryImpl.postEducationArtifactEvidence(
              educationArtifact,
              element.imageEvidence!,
            );
          }
        }

        // Experience
        for (var element in state.tempProfile!.experiences) {
          if (element!.editionType == ExperienceEditionType.originalModified) {
            await profileRepositoryImpl.putExperiencById(element);
          } else if (element.editionType == ExperienceEditionType.draft) {
            await profileRepositoryImpl.postExperience(element);
          }
        }
        // Update basic info...
        await profileRepositoryImpl.putProfileById(
          state.tempProfile!,
        );

        // Reset data in local
        await profileRepositoryImpl.deleteProfile();

        emit(state.copyWith(
          loadState: LoadState.loaded,
          profileUpdatedSuccessfully: true,
        ));
      } on Exception catch (error) {
        Logger.e(error);
        emit(state.copyWith(loadState: LoadState.error));
      }
    });

    on<AddMoreEducationArtifact>((event, emit) {
      final newEducationArtifactList = [
        ...state.tempProfile!.educationArtifacts,
        EducationArtifact(
          id: randomString(10),
          editionType: EducationArtifactEditionType.draft,
        ),
      ];
      emit(
        state.copyWith(
          tempProfile: state.tempProfile!.copyWith(
            educationArtifacts: newEducationArtifactList,
          ),
        ),
      );
    });

    on<AddMoreExperience>((event, emit) {
      final newExperienceList = [
        ...state.tempProfile!.experiences,
        Experience(
          id: randomString(10),
          editionType: ExperienceEditionType.draft,
        ),
      ];
      emit(
        state.copyWith(
          tempProfile: state.tempProfile!.copyWith(
            experiences: newExperienceList,
          ),
        ),
      );
    });

    on<DeleteEducationArtifact>((event, emit) async {
      final newEducationArtifactList = [
        ...state.tempProfile!.educationArtifacts,
      ]..removeWhere((element) => element!.id == event.educationArtifact.id);

      emit(state.copyWith(
        profile: state.profile!.copyWith(
          educationArtifacts: newEducationArtifactList,
        ),
      ));

      add(PrepareTemporaryDataEvent());
      if (event.educationArtifact.editionType !=
          EducationArtifactEditionType.draft) {
        try {
          await profileRepositoryImpl.deleteEducationArtifact(
            event.educationArtifact,
          );
        } on Exception {
          emit(state.copyWith(loadState: LoadState.error));
        }

        await profileRepositoryImpl.deleteProfile();
      }
    });

    on<DeleteExperience>((event, emit) async {
      final newExperienceList = [
        ...state.tempProfile!.experiences,
      ]..removeWhere((element) => element!.id == event.experience.id);

      emit(state.copyWith(
        profile: state.profile!.copyWith(
          experiences: newExperienceList,
        ),
      ));

      add(PrepareTemporaryDataEvent());

      if (event.experience.editionType != ExperienceEditionType.draft) {
        try {
          await profileRepositoryImpl.deleteExperience(
            event.experience,
          );
        } on Exception {
          emit(state.copyWith(loadState: LoadState.error));
        }

        await profileRepositoryImpl.deleteProfile();
      }
    });

    on<TemporarilyPostEducationArtifactEvidence>((event, emit) {
      emit(state.copyWith(loadState: LoadState.loading));
      final educationArtifact =
          state.tempProfile!.educationArtifacts.firstWhere(
        (element) => element!.id == event.educationArtifactId,
      );

      if (educationArtifact!.editionType ==
          EducationArtifactEditionType.original) {
        educationArtifact.editionType =
            EducationArtifactEditionType.originalModified;
      }
      educationArtifact.imageEvidence = event.xFile.path;

      emit(state.copyWith(loadState: LoadState.loaded));
    });
  }
  ProfileRepositoryImpl profileRepositoryImpl;
}
