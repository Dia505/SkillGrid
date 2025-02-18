import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_api_model.dart';
import 'package:skill_grid/features/education/data/dto/get_education_by_freelancer_id_dto.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';

part 'education_api_model.g.dart';

@JsonSerializable()
class EducationApiModel extends Equatable {
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

  const EducationApiModel(
      {this.educationId,
      required this.degreeTitle,
      required this.institutionName,
      required this.startDate,
      required this.endDate,
      required this.freelancer});

  factory EducationApiModel.fromJson(Map<String, dynamic> json) =>
      _$EducationApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$EducationApiModelToJson(this);

  factory EducationApiModel.fromEntity(EducationEntity entity) {
    return EducationApiModel(
        educationId: entity.educationId,
        degreeTitle: entity.degreeTitle,
        institutionName: entity.institutionName,
        startDate: entity.startDate,
        endDate: entity.endDate,
        freelancer: FreelancerApiModel.fromEntity(entity.freelancer));
  }

  EducationEntity toEntity() {
    return EducationEntity(
        educationId: educationId,
        degreeTitle: degreeTitle,
        institutionName: institutionName,
        startDate: startDate,
        endDate: endDate,
        freelancer: freelancer.toEntity());
  }

  static List<EducationEntity> toEntityList(List<EducationApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  static EducationApiModel fromDto(GetEducationByFreelancerIdDto dto) {
    return EducationApiModel(
      educationId: dto.educationId,
      degreeTitle: dto.degreeTitle, 
      institutionName: dto.institutionName, 
      startDate: dto.startDate,
      endDate: dto.endDate,
      freelancer: dto.freelancer
    );
  }

  @override
  List<Object?> get props => [
        educationId,
        degreeTitle,
        institutionName,
        startDate,
        endDate,
        freelancer
      ];
}
