import 'package:skill_grid/core/theme/theme_sensor/domain/entity/theme_mode_entity.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/repository/light_sensor_repository.dart';

class GetThemeModeBySensorUseCase {
  final LightSensorRepository repository;

  GetThemeModeBySensorUseCase(this.repository);

  Stream<ThemeModeEntity> execute() async* {
    const threshold = 50;

    await for (final lux in repository.getLightLevel()) {
      yield ThemeModeEntity(lux < threshold);
    }
  }

  void dispose() {
    repository.dispose();
  }
}
