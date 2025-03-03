import 'package:skill_grid/core/shake_sensor/domain/entity/shake_sensor_entity.dart';
import 'package:skill_grid/core/shake_sensor/domain/repository/shake_sensor_repository.dart';

class ShakeSensorUseCase {
  final ShakeSensorRepository shakeSensorRepository;

  ShakeSensorUseCase(this.shakeSensorRepository);

  Stream<ShakeSensorEntity> execute() {
    return shakeSensorRepository.getShakeEvents();
  }

  void dispose() {
    shakeSensorRepository.dispose();
  }
}