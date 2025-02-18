import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_hive_model.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';
import 'package:uuid/uuid.dart';

part 'education_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.educationTableId)
class EducationHiveModel extends Equatable {
  @HiveField(0)
  final String? educationId;
  @HiveField(1)
  final String degreeTitle;
  @HiveField(2)
  final String institutionName;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime endDate;
  @HiveField(5)
  final FreelancerHiveModel freelancer;

  EducationHiveModel({
    String? educationId,
    required this.degreeTitle,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
    required this.freelancer
  })  : educationId = educationId ?? const Uuid().v4();

  EducationHiveModel.initial()
    : educationId = "",
      degreeTitle = "",
      institutionName = "",
      startDate = DateTime(1970, 1, 1),
      endDate = DateTime(1970, 1, 1),
      freelancer = FreelancerHiveModel.initial();

  factory EducationHiveModel.fromEntity(EducationEntity entity) {
    return EducationHiveModel(
      educationId: entity.educationId,
      degreeTitle: entity.degreeTitle, 
      institutionName: entity.institutionName, 
      startDate: entity.startDate, 
      endDate: entity.endDate, 
      freelancer: FreelancerHiveModel.fromEntity(entity.freelancer)
    );
  }

  EducationEntity toEntity() {
    return EducationEntity(
      educationId: educationId,
      degreeTitle: degreeTitle, 
      institutionName: institutionName, 
      startDate: startDate, 
      endDate: endDate, 
      freelancer: freelancer.toEntity()
    );
  }

  @override
  List<Object?> get props => [educationId, degreeTitle, institutionName, startDate, endDate, freelancer];
}