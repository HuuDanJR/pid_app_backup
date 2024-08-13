import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'switch_event.dart';
part 'switch_state.dart';

class SwitchBloc extends Bloc<SwitchEvent, SwitchState> {
  SwitchBloc() : super( SwitchOff()) {
    on<ToggleSwitch>(_onToggleSwitch);
    on<SwitchOnEvent>(_onSwitchOn);
    on<SwitchOffEvent>(_onSwitchOff);
  }

  void _onToggleSwitch(ToggleSwitch event, Emitter<SwitchState> emit) {
    if (state is SwitchOff) {
      emit( SwitchOn());
    } else {
      emit( SwitchOff());
    }
  }

  void _onSwitchOn(SwitchOnEvent event, Emitter<SwitchState> emit) {
    emit( SwitchOn());
  }

  void _onSwitchOff(SwitchOffEvent event, Emitter<SwitchState> emit) {
    emit( SwitchOff());
  }
}