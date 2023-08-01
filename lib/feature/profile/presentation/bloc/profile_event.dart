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
