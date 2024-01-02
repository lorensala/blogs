part of 'power_data_bloc.dart';

sealed class PowerDataEvent extends Equatable {
  const PowerDataEvent();

  @override
  List<Object> get props => [];
}

final class PowerDataStarted extends PowerDataEvent {
  const PowerDataStarted();
}

final class GetPowerData extends PowerDataEvent {
  const GetPowerData();
}

final class _WatchPowerData extends PowerDataEvent {
  const _WatchPowerData();
}
