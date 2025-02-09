// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_freelancer_service_by_freelancer_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetFreelancerServiceByFreelancerIdDto
    _$GetFreelancerServiceByFreelancerIdDtoFromJson(
            Map<String, dynamic> json) =>
        GetFreelancerServiceByFreelancerIdDto(
          freelancerServiceId: json['_id'] as String,
          hourlyRate: (json['hourly_rate'] as num).toInt(),
          service: ServiceApiModel.fromJson(
              json['service_id'] as Map<String, dynamic>),
          freelancer: FreelancerApiModel.fromJson(
              json['freelancer_id'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$GetFreelancerServiceByFreelancerIdDtoToJson(
        GetFreelancerServiceByFreelancerIdDto instance) =>
    <String, dynamic>{
      '_id': instance.freelancerServiceId,
      'hourly_rate': instance.hourlyRate,
      'service_id': instance.service,
      'freelancer_id': instance.freelancer,
    };
