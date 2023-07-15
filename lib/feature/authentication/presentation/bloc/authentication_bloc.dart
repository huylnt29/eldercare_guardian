import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/enums/load_state.dart';
import '../../../../core/type_defs/email_type.dart';

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
}
