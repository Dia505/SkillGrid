import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/appointment/data/model/appointment_api_model.dart';
import 'package:skill_grid/features/auth/data/model/client_model/client_api_model.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/notification/data/dto/get_notifications_by_client_id_dto.dart';
import 'package:skill_grid/features/notification/domain/entity/notification_entity.dart';

part 'notification_api_model.g.dart';

@JsonSerializable()
class NotificationApiModel extends Equatable {
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

  const NotificationApiModel(
      {this.notificationId,
      required this.message,
      required this.notificationDate,
      required this.read,
      this.freelancer,
      this.client,
      this.appointment});

  factory NotificationApiModel.fromJson(Map<String, dynamic> json) {
    try {
      return NotificationApiModel(
          notificationId: json["_id"],
          message: json["message"],
          read: json["read"],
          notificationDate: DateTime.parse(json["notification_date"]),
          freelancer: null,
          client: ClientApiModel.fromJson(
              json["client_id"] as Map<String, dynamic>),
          appointment: AppointmentApiModel.fromJson(
              json["appointment_id"] as Map<String, dynamic>));
    } catch (e) {
      throw const FormatException(
          "Invalid JSON format for NotificationApiModel");
    }
  }

  Map<String, dynamic> toJson() => _$NotificationApiModelToJson(this);

  factory NotificationApiModel.fromEntity(NotificationEntity entity) {
    return NotificationApiModel(
        notificationId: entity.notificationId,
        message: entity.message,
        notificationDate: entity.notificationDate,
        read: entity.read,
        freelancer: entity.freelancer != null
            ? FreelancerApiModel.fromEntity(entity.freelancer!)
            : null,
        client: ClientApiModel.fromEntity(entity.client!),
        appointment: AppointmentApiModel.fromEntity(entity.appointment!));
  }

  NotificationEntity toEntity() {
    return NotificationEntity(
        notificationId: notificationId,
        message: message,
        notificationDate: notificationDate,
        read: read,
        freelancer: freelancer?.toEntity(),
        client: client?.toEntity(),
        appointment: appointment?.toEntity());
  }

  static List<NotificationEntity> toEntityList(
          List<NotificationApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static NotificationApiModel fromGetNotificationsByClientIdDto(
      GetNotificationsByClientIdDto notificationsClientDto) {
    return NotificationApiModel(
        notificationId: notificationsClientDto.notificationId,
        message: notificationsClientDto.message,
        notificationDate: notificationsClientDto.notificationDate,
        read: notificationsClientDto.read,
        freelancer: notificationsClientDto.freelancer,
        client: notificationsClientDto.client,
        appointment: notificationsClientDto.appointment);
  }

  NotificationApiModel copyWith({bool? read}) {
    return NotificationApiModel(
        message: message,
        notificationDate: notificationDate,
        read: read ?? this.read,
        freelancer: freelancer,
        client: client,
        appointment: appointment);
  }

  @override
  List<Object?> get props => [
        notificationId,
        message,
        notificationDate,
        read,
        freelancer,
        client,
        appointment
      ];
}
