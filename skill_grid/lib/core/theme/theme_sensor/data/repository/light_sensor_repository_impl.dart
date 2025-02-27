import 'dart:async';

import 'package:light/light.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/repository/light_sensor_repository.dart';

class LightSensorRepositoryImpl implements LightSensorRepository {
  final Light _light = Light();
  StreamSubscription? _lightSubscription;

  @override
  Stream<int> getLightLevel() {
    final streamController = StreamController<int>();

    _lightSubscription = _light.lightSensorStream.listen((int luxValue) {
      streamController.add(luxValue);
    });

    return streamController.stream;
  }

  @override
  void dispose() {
    _lightSubscription?.cancel();
  }
}
