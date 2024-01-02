import 'package:bloc_rxdart_example/models/power_data.dart';
import 'package:bloc_rxdart_example/service/service.dart';

final class PowerServiceImpl implements PowerService {
  @override
  Future<PowerData> getPowerData() async {
    await Future.delayed(const Duration(seconds: 1));
    return PowerData(
      voltage: 220,
      current: 10,
      lastUpdated: DateTime.now(),
    );
  }

  @override
  Future<void> notifyPowerChange(bool power) async {
    await Future.delayed(const Duration(seconds: 2));
  }
}
