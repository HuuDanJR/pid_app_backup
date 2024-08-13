part of 'switch_bloc.dart';

class SwitchEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class ToggleSwitch extends SwitchEvent {}

class SwitchOnEvent extends SwitchEvent {}

class SwitchOffEvent extends SwitchEvent {}