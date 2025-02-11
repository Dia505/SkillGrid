// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'freelancer_service_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FreelancerServiceApiModel _$FreelancerServiceApiModelFromJson(
        Map<String, dynamic> json) =>
    FreelancerServiceApiModel(
      freelancerServiceId: json['_id'] as String?,
      hourlyRate: (json['hourly_rate'] as num).toInt(),
      service:
          ServiceApiModel.fromJson(json['service_id'] as Map<String, dynamic>),
      freelancer: FreelancerApiModel.fromJson(
          json['freelancer_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FreelancerServiceApiModelToJson(
        FreelancerServiceApiModel instance) =>
    <String, dynamic>{
      '_id': instance.freelancerServiceId,
      'hourly_rate': instance.hourlyRate,
      'service_id': instance.service,
      'freelancer_id': instance.freelancer,
    };
