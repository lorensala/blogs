part of 'power_data_bloc.dart';

sealed class PowerDataState extends Equatable {
  const PowerDataState();

  @override
  List<Object> get props => [];
}

final class PowerDataLoading extends PowerDataState {}

final class PowerDataLoaded extends PowerDataState {
  const PowerDataLoaded(this.powerData);

  final PowerData powerData;

  @override
  List<Object> get props => [powerData];
}

final class PowerDataError extends PowerDataState {
  const PowerDataError({required this.failure});

  final Failure failure;

  @override
  List<Object> get props => [failure];
}
