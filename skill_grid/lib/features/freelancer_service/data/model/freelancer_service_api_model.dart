import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/freelancer_service/data/dto/get_freelancer_service_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/freelancer_service/domain/entity/freelancer_service_entity.dart';
import 'package:skill_grid/features/service/data/model/service_api_model.dart';

part 'freelancer_service_api_model.g.dart';

@JsonSerializable()
class FreelancerServiceApiModel extends Equatable {
  @JsonKey(name: '_id')
  final String? freelancerServiceId;
  @JsonKey(name: 'hourly_rate')
  final int hourlyRate;
  @JsonKey(name: 'service_id')
  final ServiceApiModel service;
  @JsonKey(name: 'freelancer_id')
  final FreelancerApiModel freelancer;

  const FreelancerServiceApiModel(
      {this.freelancerServiceId,
      required this.hourlyRate,
      required this.service,
      required this.freelancer});

  factory FreelancerServiceApiModel.fromJson(Map<String, dynamic> json) =>
      _$FreelancerServiceApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$FreelancerServiceApiModelToJson(this);

  factory FreelancerServiceApiModel.fromEntity(FreelancerServiceEntity entity) {
    return FreelancerServiceApiModel(
        freelancerServiceId: entity.freelancerServiceId,
        hourlyRate: entity.hourlyRate,
        service: ServiceApiModel.fromEntity(entity.service),
        freelancer: FreelancerApiModel.fromEntity(entity.freelancer));
  }

  FreelancerServiceEntity toEntity() {
    return FreelancerServiceEntity(
        freelancerServiceId: freelancerServiceId,
        hourlyRate: hourlyRate,
        service: service.toEntity(),
        freelancer: freelancer.toEntity());
  }

  static List<FreelancerServiceEntity> toEntityList(
          List<FreelancerServiceApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static FreelancerServiceApiModel fromDto(GetFreelancerServiceByFreelancerIdDto dto) {
    return FreelancerServiceApiModel(
      freelancerServiceId: dto.freelancerServiceId,
      hourlyRate: dto.hourlyRate, 
      service: dto.service, 
      freelancer: dto.freelancer
    );
  }

  @override
  List<Object?> get props => [freelancerServiceId, hourlyRate, service, freelancer];
}
