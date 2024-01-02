part of 'power_notifier_bloc.dart';

sealed class PowerNotifierEvent extends Equatable {
  const PowerNotifierEvent();

  @override
  List<Object> get props => [];
}

final class PowerNotifierStarted extends PowerNotifierEvent {
  const PowerNotifierStarted();
}

final class NotifyPowerChange extends PowerNotifierEvent {
  const NotifyPowerChange({required this.power});

  final bool power;

  @override
  List<Object> get props => [power];
}

final class _WatchPower extends PowerNotifierEvent {
  const _WatchPower();
}
