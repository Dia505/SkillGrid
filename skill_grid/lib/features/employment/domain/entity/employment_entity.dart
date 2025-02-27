import 'package:equatable/equatable.dart';
import 'package:skill_grid/features/auth/domain/entity/freelancer_entity.dart';

class EmploymentEntity extends Equatable {
  final String? employmentId;
  final String companyName;
  final String jobTitle;
  final DateTime startDate;
  final DateTime? endDate;
  final String? description;
  final FreelancerEntity freelancer;

  const EmploymentEntity({
    this.employmentId,
    required this.companyName,
    required this.jobTitle,
    required this.startDate,
    this.endDate,
    this.description,
    required this.freelancer
  });

  @override
  List<Object?> get props => [employmentId, companyName, jobTitle, startDate, endDate, description, freelancer];
}