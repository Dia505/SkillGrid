import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/entity/theme_mode_entity.dart';
import 'package:skill_grid/core/theme/theme_sensor/domain/use_case/get_theme_mode_by_sensor_use_case.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final GetThemeModeBySensorUseCase _getThemeModeBySensorUseCase;
  StreamSubscription? _themeSubscription;

  ThemeBloc(this._getThemeModeBySensorUseCase) : super(ThemeState(isDarkMode: false)) {
    on<ToggleTheme>((event, emit) {
      emit(ThemeState(isDarkMode: !state.isDarkMode));
    });

    on<StartAmbientTheme>((event, emit) {
      _themeSubscription = _getThemeModeBySensorUseCase.execute().listen((themeData) {
        add(UpdateThemeFromSensor(themeModeEntity: themeData));
      });
    });

    on<StopAmbientTheme>((event, emit) {
      _themeSubscription?.cancel();
      _themeSubscription = null;
      _getThemeModeBySensorUseCase.dispose();
    });

    on<UpdateThemeFromSensor>((event, emit) {
      emit(ThemeState(isDarkMode: event.themeModeEntity.isDarkMode));
    });
  }
}
