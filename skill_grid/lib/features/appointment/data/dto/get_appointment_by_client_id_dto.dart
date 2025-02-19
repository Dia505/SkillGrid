import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/freelancer_service/data/model/freelancer_service_api_model.dart';

part 'get_appointment_by_client_id_dto.g.dart';

@JsonSerializable()
class GetAppointmentByClientIdDto {
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

  GetAppointmentByClientIdDto({
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

  factory GetAppointmentByClientIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetAppointmentByClientIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetAppointmentByClientIdDtoToJson(this);
}