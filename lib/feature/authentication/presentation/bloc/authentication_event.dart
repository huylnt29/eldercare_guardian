part of 'authentication_bloc.dart';

abstract class AuthenticationEvent {}

class AutoLogInEvent extends AuthenticationEvent {
  AutoLogInEvent();
}

class EmailPasswordLogInEvent extends AuthenticationEvent {
  EmailPasswordLogInEvent({
    required this.email,
    required this.password,
  });
  Email email;
  String password;
}

class LogInWithGoogleEvent extends AuthenticationEvent {
  LogInWithGoogleEvent();
}

class LogInWithMicrosoftEvent extends AuthenticationEvent {
  LogInWithMicrosoftEvent();
}

class LogInWithAppleEvent extends AuthenticationEvent {
  LogInWithAppleEvent();
}
