import 'dart:async';

import 'package:sensors_plus/sensors_plus.dart';
import 'package:skill_grid/core/shake_sensor/domain/entity/shake_sensor_entity.dart';
import 'package:skill_grid/core/shake_sensor/domain/repository/shake_sensor_repository.dart';

class ShakeSensorRepositoryImpl implements ShakeSensorRepository {
  final double shakeThresholdGravity;
  StreamSubscription? _streamSubscription;
  StreamController<ShakeSensorEntity>? _streamController;
  DateTime? _lastShakeTime;

  ShakeSensorRepositoryImpl({this.shakeThresholdGravity = 1.9});

  @override
  Stream<ShakeSensorEntity> getShakeEvents() {
    _streamController = StreamController<ShakeSensorEntity>();
    _streamSubscription = accelerometerEvents.listen((AccelerometerEvent event) {
      double acceleration = event.x * event.x + event.y * event.y + event.z * event.z;
      double gravity = acceleration / (9.81 * 9.81);

      if (gravity > shakeThresholdGravity) {
        final now = DateTime.now();
        if (_lastShakeTime == null || now.difference(_lastShakeTime!).inMilliseconds > 500) {
          _lastShakeTime = now;
          _streamController?.add(ShakeSensorEntity());
        }
      }
    });
    return _streamController!.stream;
  }

  @override
  void dispose() {
    _streamSubscription?.cancel();
    _streamController?.close();
    _streamController = null;
  }
}