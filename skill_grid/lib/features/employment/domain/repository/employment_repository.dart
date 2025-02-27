import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/employment/domain/entity/employment_entity.dart';

abstract interface class IEmploymentRepository {
  Future<Either<Failure, List<EmploymentEntity>>> getEmploymentByFreelancerId(String freelancerId, String? token);
}