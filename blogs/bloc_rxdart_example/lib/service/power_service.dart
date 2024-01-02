import 'package:bloc_rxdart_example/models/power_data.dart';

abstract interface class PowerService {
  Future<PowerData> getPowerData();

  Future<void> notifyPowerChange(bool power);
}
