// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NotificationApiModel _$NotificationApiModelFromJson(
        Map<String, dynamic> json) =>
    NotificationApiModel(
      notificationId: json['_id'] as String?,
      message: json['message'] as String,
      notificationDate: DateTime.parse(json['notification_date'] as String),
      read: json['read'] as bool,
      freelancer: FreelancerApiModel.fromJson(
          json['freelancer_id'] as Map<String, dynamic>),
      client:
          ClientApiModel.fromJson(json['client_id'] as Map<String, dynamic>),
      appointment: AppointmentApiModel.fromJson(
          json['appointment_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$NotificationApiModelToJson(
        NotificationApiModel instance) =>
    <String, dynamic>{
      '_id': instance.notificationId,
      'message': instance.message,
      'notification_date': instance.notificationDate.toIso8601String(),
      'read': instance.read,
      'freelancer_id': instance.freelancer,
      'client_id': instance.client,
      'appointment_id': instance.appointment,
    };
