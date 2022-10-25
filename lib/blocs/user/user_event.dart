part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}

class LoadUserEvent extends UserEvent {}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;
  final BuildContext context;

  LoginUserEvent(this.email, this.password, this.context);
}

class RegisterUserEvent extends UserEvent {}
