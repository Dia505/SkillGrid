import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/service/data/model/service_api_model.dart';

part 'get_freelancer_service_by_freelancer_id_dto.g.dart';

@JsonSerializable()
class GetFreelancerServiceByFreelancerIdDto {
  @JsonKey(name: '_id')
  final String freelancerServiceId;
  @JsonKey(name: 'hourly_rate')
  final int hourlyRate;
  @JsonKey(name: 'service_id')
  final ServiceApiModel service;
  @JsonKey(name: 'freelancer_id')
  final FreelancerApiModel freelancer;

  GetFreelancerServiceByFreelancerIdDto(
      {required this.freelancerServiceId,
      required this.hourlyRate,
      required this.service,
      required this.freelancer});

  factory GetFreelancerServiceByFreelancerIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetFreelancerServiceByFreelancerIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetFreelancerServiceByFreelancerIdDtoToJson(this);
}
