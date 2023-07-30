import 'package:bloc/bloc.dart';
import 'package:eldercare_guardian/core/model/profile_model.dart';
import 'package:eldercare_guardian/feature/profile/data/repository/profile_repository_impl.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:huylnt_flutter_component/reusable_core/enums/load_state.dart';

part 'profile_event.dart';
part 'profile_state.dart';
part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc(this.profileRepositoryImpl)
      : super(const ProfileState(loadState: LoadState.initial)) {
    on<FetchDataForScreenEvent>((event, emit) async {
      emit(state.copyWith(loadState: LoadState.loading));
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
    on<PrepareTemporaryDataEvent>(
      (event, emit) => emit(
        state.copyWith(
          tempProfile: Profile.clone(state.profile!),
        ),
      ),
    );
  }
  ProfileRepositoryImpl profileRepositoryImpl;
}
