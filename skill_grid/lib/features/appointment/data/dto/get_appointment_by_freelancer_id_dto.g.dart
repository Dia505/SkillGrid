// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_appointment_by_freelancer_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAppointmentByFreelancerIdDto _$GetAppointmentByFreelancerIdDtoFromJson(
        Map<String, dynamic> json) =>
    GetAppointmentByFreelancerIdDto(
      appointmentId: json['_id'] as String?,
      appointmentPurpose: json['appointment_purpose'] as String,
      appointmentDate: DateTime.parse(json['appointment_date'] as String),
      projectDuration: ProjectDurationApiModel.fromJson(
          json['project_duration'] as Map<String, dynamic>),
      projectEndDate: json['project_end_date'] == null
          ? null
          : DateTime.parse(json['project_end_date'] as String),
      appointmentTime: json['appointment_time'] as String?,
      status: json['status'] as bool,
      freelancerService: FreelancerServiceApiModel.fromJson(
          json['freelancer_service_id'] as Map<String, dynamic>),
      client:
          ClientApiModel.fromJson(json['client_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetAppointmentByFreelancerIdDtoToJson(
        GetAppointmentByFreelancerIdDto instance) =>
    <String, dynamic>{
      '_id': instance.appointmentId,
      'appointment_purpose': instance.appointmentPurpose,
      'appointment_date': instance.appointmentDate.toIso8601String(),
      'project_duration': instance.projectDuration,
      'project_end_date': instance.projectEndDate?.toIso8601String(),
      'appointment_time': instance.appointmentTime,
      'status': instance.status,
      'freelancer_service_id': instance.freelancerService,
      'client_id': instance.client,
    };
