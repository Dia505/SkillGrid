// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'employment_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EmploymentApiModel _$EmploymentApiModelFromJson(Map<String, dynamic> json) =>
    EmploymentApiModel(
      employmentId: json['_id'] as String?,
      companyName: json['company_name'] as String,
      jobTitle: json['job_title'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: json['end_date'] == null
          ? null
          : DateTime.parse(json['end_date'] as String),
      description: json['description'] as String?,
      freelancer: FreelancerApiModel.fromJson(
          json['freelancer_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EmploymentApiModelToJson(EmploymentApiModel instance) =>
    <String, dynamic>{
      '_id': instance.employmentId,
      'company_name': instance.companyName,
      'job_title': instance.jobTitle,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'description': instance.description,
      'freelancer_id': instance.freelancer,
    };
