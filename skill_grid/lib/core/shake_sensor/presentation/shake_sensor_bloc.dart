import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_grid/core/shake_sensor/domain/use_case/shake_sensor_use_case.dart';

part 'shake_sensor_event.dart';
part 'shake_sensor_state.dart';

class ShakeSensorBloc extends Bloc<ShakeSensorEvent, ShakeSensorState> {
  final ShakeSensorUseCase shakeSensorUseCase;

  StreamSubscription? _shakeSubscription;

  ShakeSensorBloc(this.shakeSensorUseCase) : super(ShakeInitial()) {
    on<StartListeningShake>((event, emit) {
      _shakeSubscription = shakeSensorUseCase.execute().listen((shakeSensorEvent) {
        add(RefreshData());
      });
    });

    on<StopListeningShake>((event, emit) {
      _shakeSubscription?.cancel();
      shakeSensorUseCase.dispose();
    });

    on<RefreshData>((event, emit) async {
      emit(ShakeRefreshing());

      try {
        await Future.delayed(Duration(seconds: 2));
        emit(ShakeRefreshed());
      }
      catch(e) {
        emit(ShakeError(e.toString()));
      }
    });
  }
  @override
  Future<void> close() {
    _shakeSubscription?.cancel();
    shakeSensorUseCase.dispose();
    return super.close();
  }
}