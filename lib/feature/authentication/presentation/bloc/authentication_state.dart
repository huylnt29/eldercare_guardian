part of 'authentication_bloc.dart';

@freezed
class AuthenticationState with _$AuthenticationState {
  const factory AuthenticationState({
    @Default(false) bool canLoginAutomatically,
    @Default(false) bool canNavigateToOtpScreen,
    @Default(false) bool otpCorrect,
    required LoadState loadState,
  }) = _AuthenticationState;
}
