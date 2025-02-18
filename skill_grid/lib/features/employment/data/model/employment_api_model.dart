import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/employment/data/dto/get_employment_by_freelacer_id_dto.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';

part 'employment_api_model.g.dart';

@JsonSerializable()
class EmploymentApiModel extends Equatable {
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

  const EmploymentApiModel(
      {this.employmentId,
      required this.companyName,
      required this.jobTitle,
      required this.startDate,
      this.endDate,
      this.description,
      required this.freelancer});

  factory EmploymentApiModel.fromJson(Map<String, dynamic> json) =>
      _$EmploymentApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$EmploymentApiModelToJson(this);

  factory EmploymentApiModel.fromEntity(EmploymentEntity entity) {
    return EmploymentApiModel(
        employmentId: entity.employmentId,
        companyName: entity.companyName,
        jobTitle: entity.jobTitle,
        startDate: entity.startDate,
        endDate: entity.endDate,
        description: entity.description,
        freelancer: FreelancerApiModel.fromEntity(entity.freelancer));
  }

  EmploymentEntity toEntity() {
    return EmploymentEntity(
        employmentId: employmentId,
        companyName: companyName,
        jobTitle: jobTitle,
        startDate: startDate,
        endDate: endDate,
        description: description,
        freelancer: freelancer.toEntity());
  }

  static List<EmploymentEntity> toEntityList(List<EmploymentApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static EmploymentApiModel fromDto(GetEmploymentByFreelacerIdDto dto) {
    return EmploymentApiModel(
      employmentId: dto.employmentId,
      companyName: dto.companyName, 
      jobTitle: dto.jobTitle, 
      startDate: dto.startDate, 
      endDate: dto.endDate,
      description: dto.description,
      freelancer: dto.freelancer
    );
  }

  @override
  List<Object?> get props => [
        employmentId,
        companyName,
        jobTitle,
        startDate,
        endDate,
        description,
        freelancer
      ];
}
