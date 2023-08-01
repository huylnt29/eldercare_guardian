part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState({
    Profile? profile,
    Profile? tempProfile,
    @Default(false) canProfileUpdated,
    @Default(false) profileUpdatedSuccessfully,
    required LoadState loadState,
  }) = _ProfileState;
}
