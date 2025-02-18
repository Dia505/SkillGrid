// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'education_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EducationApiModel _$EducationApiModelFromJson(Map<String, dynamic> json) =>
    EducationApiModel(
      educationId: json['_id'] as String?,
      degreeTitle: json['degree_title'] as String,
      institutionName: json['institution_name'] as String,
      startDate: DateTime.parse(json['start_date'] as String),
      endDate: DateTime.parse(json['end_date'] as String),
      freelancer: FreelancerApiModel.fromJson(
          json['freelancer_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EducationApiModelToJson(EducationApiModel instance) =>
    <String, dynamic>{
      '_id': instance.educationId,
      'degree_title': instance.degreeTitle,
      'institution_name': instance.institutionName,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'freelancer_id': instance.freelancer,
    };
