part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;

  LoginUserEvent(this.email, this.password);
}

class RegisterUserEvent extends UserEvent {}
