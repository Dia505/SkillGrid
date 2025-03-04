import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

class NotificationEntity extends Equatable {
  final String? notificationId;
  final String message;
  final DateTime notificationDate;
  final bool read;
  final FreelancerEntity? freelancer;
  final ClientEntity? client;
  final AppointmentEntity? appointment;

  const NotificationEntity({
    this.notificationId,
    required this.message,
    required this.notificationDate,
    required this.read,
    this.freelancer,
    this.client,
    this.appointment
  });

  @override
  List<Object?> get props => [notificationId, message, notificationDate, read, freelancer, client, appointment];
}