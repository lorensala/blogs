part of 'power_switch_bloc.dart';

class PowerSwitchState extends Equatable {
  const PowerSwitchState(this.power);

  final bool power;

  @override
  List<Object> get props => [power];
}
