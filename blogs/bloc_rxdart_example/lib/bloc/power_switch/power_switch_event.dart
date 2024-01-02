part of 'power_switch_bloc.dart';

sealed class PowerSwitchEvent extends Equatable {
  const PowerSwitchEvent();

  @override
  List<Object> get props => [];
}

final class PowerSwitchStarted extends PowerSwitchEvent {
  const PowerSwitchStarted();
}

final class ToggleSwitch extends PowerSwitchEvent {
  const ToggleSwitch();
}

final class _WatchPower extends PowerSwitchEvent {
  const _WatchPower();
}
