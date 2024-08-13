part of 'switch_bloc.dart';

abstract class SwitchState extends Equatable {
  final bool value;

  SwitchState(this.value);

  @override
  List<Object> get props => [value];
}

class SwitchOn extends SwitchState {
  SwitchOn() : super(true);
}

class SwitchOff extends SwitchState {
  SwitchOff() : super(false);
}