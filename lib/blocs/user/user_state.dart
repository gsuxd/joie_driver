part of 'user_bloc.dart';

@immutable
abstract class UserState extends Equatable {
  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserNotLogged extends UserState {}

class UserLoading extends UserState {}

class UserLogged extends UserState {
  final UserData user;
  final DocumentReference<Map<String, dynamic>> documentReference;

  UserLogged(this.user, this.documentReference);

  @override
  List<Object> get props => [user];
}

class UserError extends UserState {
  final String message;

  UserError(this.message);

  @override
  List<Object> get props => [message];
}
