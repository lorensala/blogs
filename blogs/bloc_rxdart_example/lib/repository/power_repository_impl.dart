import 'package:bloc_rxdart_example/models/power_data.dart';
import 'package:bloc_rxdart_example/repository/power_repository.dart';
import 'package:bloc_rxdart_example/service/service.dart';
import 'package:fpdart/fpdart.dart';
import 'package:rxdart/rxdart.dart';

final class PowerRepositoryImpl implements PowerRepository {
  PowerRepositoryImpl({required PowerService service}) : _service = service;

  final PowerService _service;
  final BehaviorSubject<bool> _powerSubject =
      BehaviorSubject<bool>.seeded(false);

  @override
  Stream<bool> get powerStream => _powerSubject.stream;

  @override
  Future<Either<Failure, PowerData>> getPowerData() async {
    try {
      final data = await _service.getPowerData();

      return Right(data);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }

  @override
  bool get power => _powerSubject.valueOrNull ?? false;

  @override
  void toggle() {
    _powerSubject.add(!power);
  }

  @override
  Future<Either<Failure, Unit>> notifyPowerChange(bool power) async {
    try {
      await _service.notifyPowerChange(power);

      return const Right(unit);
    } catch (e) {
      return Left(Failure(message: e.toString()));
    }
  }
}
