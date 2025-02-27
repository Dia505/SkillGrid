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

  factory FreelancerServiceApiModel.fromJson(Map<String, dynamic> json) {
    try {
      return FreelancerServiceApiModel(
        freelancerServiceId: json["_id"],
        hourlyRate: json["hourly_rate"],
        service: json["service_id"] is Map<String, dynamic>
            ? ServiceApiModel.fromJson(json["service_id"])
            : ServiceApiModel(
                serviceId: json["service_id"], serviceName: "Unknown"),
        freelancer: json["freelancer_id"] is Map<String, dynamic>
            ? FreelancerApiModel.fromJson(json["freelancer_id"])
            : FreelancerApiModel(
                freelancerId: json["freelancer_id"],
                firstName: "Unknown",
                lastName: "Unknown",
                dateOfBirth: DateTime(1970, 1, 1),
                address: "Unknown",
                city: "Unknown",
                mobileNo: "Unknown",
                email: "Unknown",
                password: "Unknown"),
      );
    } catch (e) {
      throw const FormatException(
          "***Invalid JSON format for FreelancerServiceApiModel");
    }
  }

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

  static FreelancerServiceApiModel fromDto(
      GetFreelancerServiceByFreelancerIdDto dto) {
    return FreelancerServiceApiModel(
        freelancerServiceId: dto.freelancerServiceId,
        hourlyRate: dto.hourlyRate,
        service: dto.service,
        freelancer: dto.freelancer);
  }

  @override
  List<Object?> get props =>
      [freelancerServiceId, hourlyRate, service, freelancer];
}
