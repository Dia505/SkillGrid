part of 'shake_sensor_bloc.dart';

abstract class ShakeSensorEvent {}

class StartListeningShake extends ShakeSensorEvent {}

class StopListeningShake extends ShakeSensorEvent {}

class RefreshData extends ShakeSensorEvent {}