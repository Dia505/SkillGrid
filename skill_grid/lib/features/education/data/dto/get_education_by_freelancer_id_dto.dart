import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';

part 'get_education_by_freelancer_id_dto.g.dart';

@JsonSerializable()
class GetEducationByFreelancerIdDto {
  @JsonKey(name: '_id')
  final String? educationId;
  @JsonKey(name: 'degree_title')
  final String degreeTitle;
  @JsonKey(name: 'institution_name')
  final String institutionName;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime endDate;
  @JsonKey(name: 'freelancer_id')
  final FreelancerApiModel freelancer;

  const GetEducationByFreelancerIdDto(
      {this.educationId,
      required this.degreeTitle,
      required this.institutionName,
      required this.startDate,
      required this.endDate,
      required this.freelancer});

  factory GetEducationByFreelancerIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetEducationByFreelancerIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetEducationByFreelancerIdDtoToJson(this);
}
