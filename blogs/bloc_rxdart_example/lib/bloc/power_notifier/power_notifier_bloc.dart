import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart_example/repository/power_repository.dart';
import 'package:equatable/equatable.dart';

part 'power_notifier_event.dart';
part 'power_notifier_state.dart';

class PowerNotifierBloc extends Bloc<PowerNotifierEvent, PowerNotifierState> {
  PowerNotifierBloc({required PowerRepository repository})
      : _repository = repository,
        super(PowerNotifierLoading()) {
    on<PowerNotifierEvent>((event, emit) async {
      return switch (event) {
        PowerNotifierStarted() => add(const _WatchPower()),
        NotifyPowerChange() => _onNotifiyPowerChange(event, emit),
        _WatchPower() => await emit.onEach(_repository.powerStream,
            onData: (power) => add(NotifyPowerChange(power: power)))
      };
    });
  }

  final PowerRepository _repository;

  FutureOr<void> _onNotifiyPowerChange(
    NotifyPowerChange event,
    Emitter<PowerNotifierState> emit,
  ) async {
    emit(PowerNotifierLoading());

    final either = await _repository.notifyPowerChange(event.power);

    either.fold(
      (failure) => emit(PowerNotifierError(failure: failure)),
      (_) => emit(PowerNotifierSuccess()),
    );
  }
}
