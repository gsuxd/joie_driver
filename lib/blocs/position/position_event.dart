part of 'position_bloc.dart';

abstract class PositionEvent extends Equatable {
  const PositionEvent();

  @override
  List<Object> get props => [];
}

class GetPositionEvent extends PositionEvent {
  final BuildContext context;

  const GetPositionEvent(this.context);
}
