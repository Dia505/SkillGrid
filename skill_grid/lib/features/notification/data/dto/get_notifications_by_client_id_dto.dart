import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';

part 'get_notifications_by_client_id_dto.g.dart';

@JsonSerializable()
class GetNotificationsByClientIdDto {
  @JsonKey(name: "_id")
  final String? notificationId;
  final String message;
  @JsonKey(name: "notification_date")
  final DateTime notificationDate;
  final bool read;
  @JsonKey(name: "freelancer_id")
  final FreelancerApiModel? freelancer;
  @JsonKey(name: "client_id")
  final ClientApiModel? client;
  @JsonKey(name: "appointment_id")
  final AppointmentApiModel? appointment;

  GetNotificationsByClientIdDto({
    this.notificationId,
    required this.message,
    required this.notificationDate,
    required this.read,
    this.freelancer,
    this.client,
    this.appointment
  });

  factory GetNotificationsByClientIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetNotificationsByClientIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetNotificationsByClientIdDtoToJson(this);
}