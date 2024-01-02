part of 'power_notifier_bloc.dart';

sealed class PowerNotifierState extends Equatable {
  const PowerNotifierState();

  @override
  List<Object> get props => [];
}

final class PowerNotifierLoading extends PowerNotifierState {}

final class PowerNotifierSuccess extends PowerNotifierState {}

final class PowerNotifierError extends PowerNotifierState {
  const PowerNotifierError({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
