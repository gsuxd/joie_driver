part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  const UserState();
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserNotLogged extends UserState {}

class UserLoading extends UserState {}

class UserLogged extends UserState {
  final UserData user;
  final DocumentReference<Map<String, dynamic>> documentReference;

  const UserLogged(this.user, this.documentReference);

  @override
  List<Object> get props => [user];
}

class UserNotVerified extends UserState {
  final UserData user;
  final DocumentReference<Map<String, dynamic>> documentReference;
  const UserNotVerified(this.documentReference, this.user);
  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  const UserError(this.message);

  @override
  List<Object> get props => [message];
}
