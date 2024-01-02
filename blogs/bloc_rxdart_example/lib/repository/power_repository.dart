import 'package:bloc_rxdart_example/models/models.dart';
import 'package:equatable/equatable.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class PowerRepository {
  Stream<bool> get powerStream;

  bool get power;

  void toggle();

  Future<Either<Failure, PowerData>> getPowerData();

  Future<Either<Failure, Unit>> notifyPowerChange(bool power);
}

class Failure extends Equatable {
  const Failure({required this.message});

  final String message;

  @override
  List<Object?> get props => [message];
}
