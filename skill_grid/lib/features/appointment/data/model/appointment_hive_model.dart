import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_hive_model.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_hive_model.dart';
import 'package:uuid/uuid.dart';

part 'appointment_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.appointmentTableId)
class AppointmentHiveModel extends Equatable {
  @HiveField(0)
  final String? appointmentId;
  @HiveField(1)
  final String appointmentPurpose;
  @HiveField(2)
  final DateTime appointmentDate;
  @HiveField(3)
  final ProjectDurationHiveModel projectDuration;
  @HiveField(4)
  final DateTime? projectEndDate;
  @HiveField(5)
  final String? appointmentTime;
  @HiveField(6)
  final bool status;
  @HiveField(7)
  final FreelancerServiceHiveModel freelancerService;
  @HiveField(8)
  final ClientHiveModel client;

  AppointmentHiveModel({
    String? appointmentId,
    required this.appointmentPurpose,
    required this.appointmentDate,
    required this.projectDuration,
    this.projectEndDate,
    this.appointmentTime,
    required this.status,
    required this.freelancerService,
    required this.client,
  })  : appointmentId = appointmentId ?? const Uuid().v4();

  AppointmentHiveModel.initial()
    : appointmentId = "",
      appointmentPurpose = "",
      appointmentDate = DateTime(1970, 1, 1),
      projectDuration = const ProjectDurationHiveModel(value: 1, unit: "day"), 
      projectEndDate = null,
      appointmentTime = "",
      status = false,
      freelancerService = FreelancerServiceHiveModel.initial(), 
      client = const ClientHiveModel.initial();

  factory AppointmentHiveModel.fromEntity(AppointmentEntity entity) {
    return AppointmentHiveModel(
      appointmentId: entity.appointmentId,
      appointmentPurpose: entity.appointmentPurpose, 
      appointmentDate: entity.appointmentDate, 
      projectDuration: ProjectDurationHiveModel(value: entity.projectDuration.value, unit: entity.projectDuration.unit), 
      projectEndDate: entity.projectEndDate,
      appointmentTime: entity.appointmentTime,
      status: entity.status, 
      freelancerService: FreelancerServiceHiveModel.fromEntity(entity.freelancerService), 
      client: ClientHiveModel.fromEntity(entity.client)
    );
  }

  AppointmentEntity toEntity() {
    return AppointmentEntity(
      appointmentId: appointmentId,
      appointmentPurpose: appointmentPurpose, 
      appointmentDate: appointmentDate, 
      projectDuration: projectDuration.toEntity(), 
      projectEndDate: projectEndDate,
      appointmentTime: appointmentTime,
      status: status, 
      freelancerService: freelancerService.toEntity(), 
      client: client.toEntity()
    );
  }

  AppointmentHiveModel copyWith({
    String? appointmentPurpose
  }) {
    return AppointmentHiveModel(
      appointmentId: appointmentId,
      appointmentPurpose: appointmentPurpose ?? this.appointmentPurpose, 
      appointmentDate: appointmentDate, 
      projectDuration: projectDuration, 
      projectEndDate: projectEndDate,
      appointmentTime: appointmentTime,
      status: status, freelancerService: 
      freelancerService, 
      client: client
    );
  }

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

@HiveType(typeId: HiveTableConstant.projectDurationTableId)
class ProjectDurationHiveModel extends Equatable {
  @HiveField(0)
  final int value;
  @HiveField(1)
  final String unit;

  const ProjectDurationHiveModel({
    required this.value,
    required this.unit,
  });

  ProjectDuration toEntity() {
    return ProjectDuration(
      value: value,
      unit: unit,
    );
  }

  @override
  List<Object> get props => [value, unit];
}