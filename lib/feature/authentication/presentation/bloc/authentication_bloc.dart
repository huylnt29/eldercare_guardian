import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';
part 'authentication_bloc.freezed.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc()
      : super(
          const AuthenticationState(
            loadState: LoadState.initial,
          ),
        ) {
    listenToEvents();
  }

  void listenToEvents() {
    on<AutoLogInEvent>((event, emit) async {
      await _logInAutomatically(event, emit);
    });
    on<EmailPasswordLogInEvent>((event, emit) async {
      await _logInWithEmailPassword(event, emit);
    });
  }

  Future<void> _logInAutomatically(
    AutoLogInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(loadState: LoadState.loading));

    emit(state.copyWith(
      loadState: LoadState.loaded,
      canLoginAutomatically: false,
    ));
  }

  Future<void> _logInWithEmailPassword(
    EmailPasswordLogInEvent event,
    Emitter<AuthenticationState> emit,
  ) async {
    emit(state.copyWith(loadState: LoadState.loading));

    emit(state.copyWith(
      loadState: LoadState.loaded,
      credentialCorrect: true,
    ));
  }
}
