import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

class EducationEntity extends Equatable {
  final String? educationId;
  final String degreeTitle;
  final String institutionName;
  final DateTime startDate;
  final DateTime endDate;
  final FreelancerEntity freelancer;

  const EducationEntity({
    this.educationId,
    required this.degreeTitle,
    required this.institutionName,
    required this.startDate,
    required this.endDate,
    required this.freelancer
  });

  @override
  List<Object?> get props => [educationId, degreeTitle, institutionName, startDate, endDate, freelancer];
}