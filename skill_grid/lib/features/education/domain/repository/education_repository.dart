import 'package:dartz/dartz.dart';
import 'package:skill_grid/core/error/failure.dart';
import 'package:skill_grid/features/education/domain/entity/education_entity.dart';

abstract interface class IEducationRepository {
  Future<Either<Failure, List<EducationEntity>>> getEducationByFreelancerId(String freelancerId, String? token);
}