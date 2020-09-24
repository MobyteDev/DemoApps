import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial());

  @override
  Stream<AuthState> mapEventToState(
    AuthEvent event,
  ) async* {
    if (event is CheckDataEvent) {
      bool logSuc = event.login.trim().length > 5;
      bool passSuc = event.password.trim().length > 5;
      if (logSuc && passSuc) {
        yield LoginSuccess();
        yield AuthInitial();
      } else {
        yield AuthInitial(loginFailed: !logSuc, passFailed: !passSuc);
      }
    }
  }
}
