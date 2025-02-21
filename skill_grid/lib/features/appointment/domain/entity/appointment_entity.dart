import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/auth/domain/entity/client_entity.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';

class AppointmentEntity extends Equatable {
  final String? appointmentId;
  final String appointmentPurpose;
  final DateTime appointmentDate;
  final ProjectDuration projectDuration;
  final DateTime? projectEndDate;
  final String? appointmentTime;
  final bool status;
  final FreelancerServiceEntity freelancerService;
  final ClientEntity client;

  const AppointmentEntity( {
    this.appointmentId,
    required this.appointmentPurpose,
    required this.appointmentDate,
    required this.projectDuration,
    this.projectEndDate,
    this.appointmentTime,
    required this.status,
    required this.freelancerService,
    required this.client,
  });

  AppointmentEntity.empty()
      : appointmentId = "_empty.appointmentId",
        appointmentPurpose = "_empty.appointmentPurpose",
        appointmentDate = DateTime(1970),
        projectDuration = const ProjectDuration(value: 0, unit: "days"),
        projectEndDate = null,
        appointmentTime = null,
        status = false,
        freelancerService = FreelancerServiceEntity.empty(),
        client = const ClientEntity.empty();

  @override
  List<Object?> get props => [
        appointmentId,
        appointmentPurpose,
        appointmentDate,
        projectDuration,
        projectEndDate,
        appointmentTime,
        status,
        freelancerService,
        client,
      ];
}

class ProjectDuration extends Equatable {
  final int value;
  final String unit;

  const ProjectDuration({
    required this.value,
    required this.unit,
  });

  @override
  List<Object> get props => [value, unit];
}