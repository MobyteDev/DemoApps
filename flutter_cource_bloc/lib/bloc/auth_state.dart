part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {}

class AuthInitial extends AuthState {
  final bool loginFailed;
  final bool passFailed;

  AuthInitial({this.loginFailed = false, this.passFailed = false});
  @override
  List<Object> get props => [];
}

class LoginSuccess extends AuthState {
  @override
  List<Object> get props => [];
}
