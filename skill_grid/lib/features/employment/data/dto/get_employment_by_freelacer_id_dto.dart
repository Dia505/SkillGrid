import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';

part 'get_employment_by_freelacer_id_dto.g.dart';

@JsonSerializable()
class GetEmploymentByFreelacerIdDto {
  @JsonKey(name: '_id')
  final String? employmentId;
  @JsonKey(name: 'company_name')
  final String companyName;
  @JsonKey(name: 'job_title')
  final String jobTitle;
  @JsonKey(name: 'start_date')
  final DateTime startDate;
  @JsonKey(name: 'end_date')
  final DateTime? endDate;
  final String? description;
  @JsonKey(name: 'freelancer_id')
  final FreelancerApiModel freelancer;

  GetEmploymentByFreelacerIdDto(
      {this.employmentId,
      required this.companyName,
      required this.jobTitle,
      required this.startDate,
      this.endDate,
      this.description,
      required this.freelancer});

  factory GetEmploymentByFreelacerIdDto.fromJson(Map<String, dynamic> json) =>
      _$GetEmploymentByFreelacerIdDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetEmploymentByFreelacerIdDtoToJson(this);
}
