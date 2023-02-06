part of 'registro_bloc.dart';

abstract class RegistroEvent extends Equatable {
  const RegistroEvent();

  @override
  List<Object> get props => [];
}

class InitializeRegistroEvent extends RegistroEvent {
  final UserType userType;
  final BuildContext ctx;
  const InitializeRegistroEvent(this.userType, this.ctx);
}

class NextScreenRegistroEvent extends RegistroEvent {
  final BuildContext ctx;
  final Widget page;
  final RegistroData data;
  const NextScreenRegistroEvent(this.ctx, this.page, this.data);
}

class ResumeRegistroEvent extends RegistroEvent {
  final BuildContext ctx;
  const ResumeRegistroEvent(this.ctx);
}

class EnviarRegistroEvent extends RegistroEvent {
  final BuildContext ctx;
  final bool isReanuded;
  final RegistroData data;
  const EnviarRegistroEvent(this.ctx, this.data, {this.isReanuded = false});
}
