import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/dto/get_appointment_by_client_id_dto.dart';
import 'package:skill_grid/features/appointment/data/dto/get_appointment_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/appointment/data/dto/get_appointment_by_id_dto.dart';
import 'package:skill_grid/features/appointment/domain/entity/appointment_entity.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_api_model.dart';

part 'appointment_api_model.g.dart';

@JsonSerializable()
class AppointmentApiModel extends Equatable {
  @JsonKey(name: "_id")
  final String? appointmentId;
  @JsonKey(name: "appointment_purpose")
  final String appointmentPurpose;
  @JsonKey(name: "appointment_date")
  final DateTime appointmentDate;
  @JsonKey(name: "project_duration")
  final ProjectDurationApiModel projectDuration;
  @JsonKey(name: "project_end_date")
  final DateTime? projectEndDate;
  @JsonKey(name: "appointment_time")
  final String? appointmentTime;
  final bool status;
  @JsonKey(name: "freelancer_service_id")
  final FreelancerServiceApiModel freelancerService;
  @JsonKey(name: "client_id")
  final ClientApiModel client;

  const AppointmentApiModel({
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

  // factory AppointmentApiModel.fromJson(Map<String, dynamic> json) =>
  //     _$AppointmentApiModelFromJson(json);

  factory AppointmentApiModel.fromJson(Map<String, dynamic> json) {
    json.forEach((key, value) {
      print("Key: $key, Type: ${value.runtimeType}, Value: $value");
    });
    try {
      return AppointmentApiModel(
        appointmentId: json["_id"],
        appointmentPurpose: json["appointment_purpose"],
        appointmentDate: DateTime.parse(json["appointment_date"]),
        projectDuration:
            ProjectDurationApiModel.fromJson(json["project_duration"]),
        projectEndDate: json["project_end_date"] != null
            ? DateTime.parse(json["project_end_date"])
            : null,
        appointmentTime: json["appointment_time"],
        status: json["status"],
        freelancerService: FreelancerServiceApiModel.fromJson(
            json['freelancer_service_id'] as Map<String, dynamic>),
        client: ClientApiModel.fromJson(json["client_id"]),
      );
    } catch (e, stacktrace) {
      print("Error parsing AppointmentApiModel: $e");
      print(stacktrace);
      throw const FormatException(
          "Invalid JSON format for AppointmentApiModel");
    }
  }

  Map<String, dynamic> toJson() => _$AppointmentApiModelToJson(this);

  factory AppointmentApiModel.fromEntity(AppointmentEntity entity) {
    return AppointmentApiModel(
        appointmentId: entity.appointmentId,
        appointmentPurpose: entity.appointmentPurpose,
        appointmentDate: entity.appointmentDate,
        projectDuration: ProjectDurationApiModel(
            value: entity.projectDuration.value,
            unit: entity.projectDuration.unit),
        projectEndDate: entity.projectEndDate,
        appointmentTime: entity.appointmentTime,
        status: entity.status,
        freelancerService:
            FreelancerServiceApiModel.fromEntity(entity.freelancerService),
        client: ClientApiModel.fromEntity(entity.client));
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
        client: client.toEntity());
  }

  static List<AppointmentEntity> toEntityList(
          List<AppointmentApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static AppointmentApiModel fromGetAppointmentByClientIdDto(
      GetAppointmentByClientIdDto appointmentClientDto) {
    return AppointmentApiModel(
        appointmentId: appointmentClientDto.appointmentId,
        appointmentPurpose: appointmentClientDto.appointmentPurpose,
        appointmentDate: appointmentClientDto.appointmentDate,
        projectDuration: appointmentClientDto.projectDuration,
        appointmentTime: appointmentClientDto.appointmentTime,
        projectEndDate: appointmentClientDto.projectEndDate,
        status: appointmentClientDto.status,
        freelancerService: appointmentClientDto.freelancerService,
        client: appointmentClientDto.client);
  }

  static AppointmentApiModel fromGetAppointmentByFreelancerIdDto(
      GetAppointmentByFreelancerIdDto appointmentFreelancerDto) {
    return AppointmentApiModel(
        appointmentId: appointmentFreelancerDto.appointmentId,
        appointmentPurpose: appointmentFreelancerDto.appointmentPurpose,
        appointmentDate: appointmentFreelancerDto.appointmentDate,
        projectDuration: appointmentFreelancerDto.projectDuration,
        appointmentTime: appointmentFreelancerDto.appointmentTime,
        projectEndDate: appointmentFreelancerDto.projectEndDate,
        status: appointmentFreelancerDto.status,
        freelancerService: appointmentFreelancerDto.freelancerService,
        client: appointmentFreelancerDto.client);
  }

  static AppointmentEntity findAppointmentByIdDtoToEntity(
      GetAppointmentByIdDto appointmentDto) {
    return AppointmentEntity(
        appointmentId: appointmentDto.appointmentId,
        appointmentPurpose: appointmentDto.appointmentPurpose,
        appointmentDate: appointmentDto.appointmentDate,
        projectDuration: appointmentDto.projectDuration.toEntity(),
        appointmentTime: appointmentDto.appointmentTime,
        projectEndDate: appointmentDto.projectEndDate,
        status: appointmentDto.status,
        freelancerService: appointmentDto.freelancerService.toEntity(),
        client: appointmentDto.client.toEntity());
  }

  AppointmentApiModel copyWith({String? appointmentPurpose}) {
    return AppointmentApiModel(
        appointmentId: appointmentId,
        appointmentPurpose: appointmentPurpose ?? this.appointmentPurpose,
        appointmentDate: appointmentDate,
        projectDuration: projectDuration,
        appointmentTime: appointmentTime,
        projectEndDate: projectEndDate,
        status: status,
        freelancerService: freelancerService,
        client: client);
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

@JsonSerializable()
class ProjectDurationApiModel extends Equatable {
  final int value;
  final String unit;

  const ProjectDurationApiModel({
    required this.value,
    required this.unit,
  });

  ProjectDuration toEntity() {
    return ProjectDuration(
      value: value,
      unit: unit,
    );
  }

  factory ProjectDurationApiModel.fromJson(Map<String, dynamic> json) {
    return ProjectDurationApiModel(
      unit: json["unit"],
      value: (json["value"] is int)
          ? json["value"]
          : (json["value"] as num).toInt(),
    );
  }

  @override
  List<Object> get props => [value, unit];
}
