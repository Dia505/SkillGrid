// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_portfolio_by_freelancer_id_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetPortfolioByFreelancerIdDto _$GetPortfolioByFreelancerIdDtoFromJson(
        Map<String, dynamic> json) =>
    GetPortfolioByFreelancerIdDto(
      portfolioId: json['_id'] as String?,
      filePath:
          (json['file_path'] as List<dynamic>).map((e) => e as String).toList(),
      uploadDate: DateTime.parse(json['upload_date'] as String),
      freelancerService: FreelancerServiceApiModel.fromJson(
          json['freelancer_service_id'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$GetPortfolioByFreelancerIdDtoToJson(
        GetPortfolioByFreelancerIdDto instance) =>
    <String, dynamic>{
      '_id': instance.portfolioId,
      'file_path': instance.filePath,
      'upload_date': instance.uploadDate.toIso8601String(),
      'freelancer_service_id': instance.freelancerService,
    };
