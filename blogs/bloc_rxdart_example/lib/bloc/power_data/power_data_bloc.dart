import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_rxdart_example/models/power_data.dart';
import 'package:bloc_rxdart_example/repository/repository.dart';
import 'package:equatable/equatable.dart';

part 'power_data_event.dart';
part 'power_data_state.dart';

class PowerDataBloc extends Bloc<PowerDataEvent, PowerDataState> {
  PowerDataBloc({required PowerRepository repository})
      : _repository = repository,
        super(PowerDataLoading()) {
    on<PowerDataEvent>((event, emit) async {
      return switch (event) {
        PowerDataStarted() => add(const _WatchPowerData()),
        GetPowerData() => _onGetPowerData(event, emit),
        _WatchPowerData() => await emit.onEach(
            _repository.powerStream,
            onData: (power) {
              if (!power) return;

              add(const GetPowerData());
            },
          )
      };
    });
  }

  final PowerRepository _repository;

  FutureOr<void> _onGetPowerData(
    GetPowerData event,
    Emitter<PowerDataState> emit,
  ) async {
    emit(PowerDataLoading());

    final either = await _repository.getPowerData();

    either.fold(
      (failure) => emit(PowerDataError(failure: failure)),
      (data) => emit(PowerDataLoaded(data)),
    );
  }
}
