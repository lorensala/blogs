import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart_example/repository/power_repository.dart';
import 'package:equatable/equatable.dart';

part 'power_switch_event.dart';
part 'power_switch_state.dart';

class PowerSwitchBloc extends Bloc<PowerSwitchEvent, PowerSwitchState> {
  PowerSwitchBloc({required PowerRepository repository})
      : _repository = repository,
        super(const PowerSwitchState(false)) {
    on<PowerSwitchEvent>((event, emit) async {
      return switch (event) {
        PowerSwitchStarted() => add(const _WatchPower()),
        ToggleSwitch() => _repository.toggle(),
        _WatchPower() => await emit.forEach(_repository.powerStream,
            onData: (power) => PowerSwitchState(power))
      };
    });
  }

  final PowerRepository _repository;
}
