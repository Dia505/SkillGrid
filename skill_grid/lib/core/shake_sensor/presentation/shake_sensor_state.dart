part of 'shake_sensor_bloc.dart';

abstract class ShakeSensorState {}

class ShakeInitial extends ShakeSensorState {}

class ShakeRefreshing extends ShakeSensorState {}

class ShakeRefreshed extends ShakeSensorState {}

class ShakeError extends ShakeSensorState {
  final String message;

  ShakeError(this.message);
}