import 'package:equatable/equatable.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:skill_grid/app/constants/hive_table_constant.dart';
import 'package:skill_grid/features/auth/data/model/freelancer_model/freelancer_hive_model.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';
import 'package:uuid/uuid.dart';

part 'employment_hive_model.g.dart';

@HiveType(typeId: HiveTableConstant.employmentTableId)
class EmploymentHiveModel extends Equatable {
  @HiveField(0)
  final String? employmentId;
  @HiveField(1)
  final String companyName;
  @HiveField(2)
  final String jobTitle;
  @HiveField(3)
  final DateTime startDate;
  @HiveField(4)
  final DateTime? endDate;
  @HiveField(5)
  final String? description;
  @HiveField(6)
  final FreelancerHiveModel freelancer;

  EmploymentHiveModel({
    String? employmentId,
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    this.endDate,
    this.description,
    required this.freelancer
  })  : employmentId = employmentId ?? const Uuid().v4();

  EmploymentHiveModel.initial()
    : employmentId = "",
      companyName = "",
      jobTitle = "",
      startDate = DateTime(1970, 1, 1),
      endDate = DateTime(1970, 1, 1),
      description = "",
      freelancer = FreelancerHiveModel.initial();
  
  factory EmploymentHiveModel.fromEntity(EmploymentEntity entity) {
    return EmploymentHiveModel(
      employmentId: entity.employmentId,
      companyName: entity.companyName, 
      jobTitle: entity.jobTitle, 
      startDate: entity.startDate, 
      endDate: entity.endDate,
      description: entity.description,
      freelancer: FreelancerHiveModel.fromEntity(entity.freelancer)
    );
  }

  EmploymentEntity toEntity() {
    return EmploymentEntity(
      employmentId: employmentId,
      companyName: companyName, 
      jobTitle: jobTitle, 
      startDate: startDate, 
      endDate: endDate,
      description: description,
      freelancer: freelancer.toEntity()
    );
  }

  @override
  List<Object?> get props => [employmentId, companyName, jobTitle, startDate, endDate, description, freelancer];
}