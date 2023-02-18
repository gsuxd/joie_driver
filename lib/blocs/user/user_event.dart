part of 'user_bloc.dart';

@immutable
abstract class UserEvent extends Equatable {
  const UserEvent();
  @override
  List<Object> get props => [];
}

class LoadUserEvent extends UserEvent {}

class LoginUserEvent extends UserEvent {
  final String email;
  final String password;
  final BuildContext context;

  const LoginUserEvent(this.email, this.password, this.context);
}

enum VerifyType {
  shareLink,
  payout,
}

class VerifyUserEvent extends UserEvent {
  final VerifyType type;
  final BuildContext context;
  const VerifyUserEvent(this.type, this.context);
}
