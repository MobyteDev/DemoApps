part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent extends Equatable {}

class CheckDataEvent extends AuthEvent {
  String login;
  String password;

  @override
  List<Object> get props => [login, password];
}
