// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PortfolioApiModel _$PortfolioApiModelFromJson(Map<String, dynamic> json) =>
    PortfolioApiModel(
      portfolioId: json['_id'] as String?,
      filePath: (json['file_path'] as List?)?.map((e) => e as String).toList() ?? [],
      uploadDate: DateTime.parse(json['upload_date'] as String),
      freelancerService: FreelancerServiceApiModel.fromJson(
          json['freelancer_service_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PortfolioApiModelToJson(PortfolioApiModel instance) =>
    <String, dynamic>{
      '_id': instance.portfolioId,
      'file_path': instance.filePath,
      'upload_date': instance.uploadDate.toIso8601String(),
      'freelancer_service_id': instance.freelancerService,
    };
