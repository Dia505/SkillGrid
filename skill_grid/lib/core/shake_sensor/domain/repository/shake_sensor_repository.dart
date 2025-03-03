import 'package:skill_grid/core/shake_sensor/domain/entity/shake_sensor_entity.dart';

abstract class ShakeSensorRepository {
  Stream<ShakeSensorEntity> getShakeEvents();
  void dispose();
}